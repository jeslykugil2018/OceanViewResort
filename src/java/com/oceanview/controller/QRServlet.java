package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;
import java.util.ArrayList;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * High-Reliability QR Servlet for Ocean View Resort.
 * Uses QRServer API (api.qrserver.com) for guaranteed image generation.
 * Implements intelligent IP detection to ensure cross-device scannability.
 */
@WebServlet("/QRServlet")
public class QRServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String resNumStr = request.getParameter("reservationNumber");
        String manualIp = request.getParameter("manualIp");

        if (resNumStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing reservationNumber");
            return;
        }

        try {
            int resNum = Integer.parseInt(resNumStr);

            // --- 1. Infrastructure Detection (URL Building) ---
            String scheme = request.getScheme();
            String serverName = request.getServerName();
            int serverPort = request.getServerPort();
            String contextPath = request.getContextPath();

            // Intelligent IP Detection: If accessing via localhost, find a scannable
            // network IP
            if (manualIp != null && !manualIp.isEmpty()) {
                serverName = manualIp;
            } else if ("localhost".equals(serverName) || "127.0.0.1".equals(serverName)
                    || serverName.startsWith("0:0")) {
                String detectedIp = detectLocalIp();
                if (detectedIp != null) {
                    serverName = detectedIp;
                }
            }

            String portPart = ((scheme.equals("http") && serverPort == 80)
                    || (scheme.equals("https") && serverPort == 443)) ? "" : ":" + serverPort;
            String verificationUrl = scheme + "://" + serverName + portPart + contextPath
                    + "/viewQRDetails.jsp?reservationNumber=" + resNum;

            // --- 2. Generation (Cloud Strategy) ---
            // We use api.qrserver.com because Google Charts is now 404 in many regions
            String cloudQrUrl = "https://api.qrserver.com/v1/create-qr-code/?size=450x450&data="
                    + URLEncoder.encode(verificationUrl, StandardCharsets.UTF_8.toString());

            // Redirect the browser to the generated QR image
            response.sendRedirect(cloudQrUrl);

        } catch (Exception e) {
            response.setContentType("text/plain");
            response.getWriter().println("QR System Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Attempts to find a non-loopback IPv4 address on the host.
     */
    private String detectLocalIp() {
        try {
            Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();
            while (interfaces.hasMoreElements()) {
                NetworkInterface iface = interfaces.nextElement();
                if (iface.isLoopback() || !iface.isUp())
                    continue;

                Enumeration<InetAddress> addresses = iface.getInetAddresses();
                while (addresses.hasMoreElements()) {
                    InetAddress addr = addresses.nextElement();
                    String ip = addr.getHostAddress();
                    if (!ip.contains(":")
                            && (ip.startsWith("192.168.") || ip.startsWith("10.") || ip.startsWith("172."))) {
                        return ip;
                    }
                }
            }
        } catch (Exception e) {
        }
        return null;
    }
}
