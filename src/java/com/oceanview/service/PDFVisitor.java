package com.oceanview.service;

import com.oceanview.model.Reservation;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.itextpdf.text.pdf.draw.LineSeparator;
import java.util.Date;

/**
 * Professional PDF Invoice Generator using Visitor Pattern
 */
public class PDFVisitor implements ReservationVisitor {

    private static final BaseColor PRIMARY_COLOR = new BaseColor(26, 60, 90); // Deep Navy
    private static final BaseColor SECONDARY_COLOR = new BaseColor(212, 175, 55); // Metallic Gold
    private static final BaseColor LIGHT_GRAY = new BaseColor(245, 247, 250);
    private static final BaseColor DARK_TEXT = new BaseColor(50, 50, 50);

    private static final Font RESORT_NAME_FONT = FontFactory.getFont(FontFactory.TIMES_BOLDITALIC, 32, PRIMARY_COLOR);
    private static final Font TAGLINE_FONT = FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 12, SECONDARY_COLOR);
    private static final Font INVOICE_TITLE_FONT = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 24, SECONDARY_COLOR);
    private static final Font SECTION_HEADER_FONT = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, PRIMARY_COLOR);
    private static final Font NORMAL_FONT = FontFactory.getFont(FontFactory.HELVETICA, 10, DARK_TEXT);
    private static final Font NORMAL_BOLD_FONT = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, DARK_TEXT);
    private static final Font TH_FONT = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, BaseColor.WHITE);
    private static final Font GRAND_TOTAL_FONT = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, PRIMARY_COLOR);
    private static final Font FOOTER_FONT = FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 9, BaseColor.GRAY);

    @Override
    public void visit(Reservation res, String filePath) {
        Document document = new Document(PageSize.A4, 40, 40, 50, 50);
        try {
            PdfWriter.getInstance(document, new FileOutputStream(filePath));
            document.open();

            // --- 1. Header (Logo & Contact info) ---
            PdfPTable headerTable = new PdfPTable(2);
            headerTable.setWidthPercentage(100);
            headerTable.setWidths(new float[] { 6f, 4f });

            PdfPCell logoCell = new PdfPCell();
            logoCell.setBorder(Rectangle.NO_BORDER);
            logoCell.addElement(new Paragraph("Ocean View Resort", RESORT_NAME_FONT));
            logoCell.addElement(new Paragraph("A Touch of Paradise", TAGLINE_FONT));
            headerTable.addCell(logoCell);

            PdfPCell contactCell = new PdfPCell();
            contactCell.setBorder(Rectangle.NO_BORDER);
            contactCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            Paragraph p1 = new Paragraph("123 Ocean Boulevard, Galle, LK", NORMAL_FONT);
            p1.setAlignment(Element.ALIGN_RIGHT);
            contactCell.addElement(p1);
            Paragraph p2 = new Paragraph("+94 11 234 5678  |  info@oceanview.com", NORMAL_FONT);
            p2.setAlignment(Element.ALIGN_RIGHT);
            contactCell.addElement(p2);
            headerTable.addCell(contactCell);

            document.add(headerTable);

            // Add a separator line
            document.add(new Paragraph(" "));
            LineSeparator ls = new LineSeparator(1.5f, 100, SECONDARY_COLOR, Element.ALIGN_CENTER, -5);
            document.add(new Chunk(ls));
            document.add(new Paragraph(" "));

            // --- 2. Invoice Title & Meta ---
            PdfPTable metaTable = new PdfPTable(2);
            metaTable.setWidthPercentage(100);
            metaTable.setWidths(new float[] { 5f, 5f });

            PdfPCell titleCell = new PdfPCell(new Paragraph("GUEST INVOICE", INVOICE_TITLE_FONT));
            titleCell.setBorder(Rectangle.NO_BORDER);
            metaTable.addCell(titleCell);

            PdfPCell invMetaCell = new PdfPCell();
            invMetaCell.setBorder(Rectangle.NO_BORDER);
            Paragraph invNum = new Paragraph("Invoice No: INV-" + (res.getReservationNumber() + 1000),
                    NORMAL_BOLD_FONT);
            invNum.setAlignment(Element.ALIGN_RIGHT);
            Paragraph invDate = new Paragraph("Date: " + formatDate(new Date()), NORMAL_FONT);
            invDate.setAlignment(Element.ALIGN_RIGHT);
            invMetaCell.addElement(invNum);
            invMetaCell.addElement(invDate);
            metaTable.addCell(invMetaCell);

            document.add(metaTable);
            document.add(new Paragraph("\n"));

            // --- 3. Guest & Stay Details ---
            PdfPTable infoTable = new PdfPTable(2);
            infoTable.setWidthPercentage(100);
            infoTable.setSpacingAfter(20f);

            PdfPCell billToCell = new PdfPCell();
            billToCell.setBorder(Rectangle.NO_BORDER);
            billToCell.addElement(new Paragraph("BILLED TO:", SECTION_HEADER_FONT));
            billToCell.addElement(
                    new Paragraph(res.getGuestName() != null && !res.getGuestName().isEmpty() ? res.getGuestName()
                            : "Guest #" + res.getGuestId(), NORMAL_BOLD_FONT));
            billToCell.addElement(new Paragraph(
                    res.getGuestAddress() != null && !res.getGuestAddress().isEmpty() ? res.getGuestAddress() : "N/A",
                    NORMAL_FONT));
            billToCell.addElement(new Paragraph(
                    res.getGuestContact() != null && !res.getGuestContact().isEmpty() ? res.getGuestContact() : "N/A",
                    NORMAL_FONT));
            infoTable.addCell(billToCell);

            PdfPCell stayCell = new PdfPCell();
            stayCell.setBorder(Rectangle.NO_BORDER);
            stayCell.addElement(new Paragraph("STAY DETAILS:", SECTION_HEADER_FONT));
            stayCell.addElement(new Paragraph("Reservation #: " + res.getReservationNumber(), NORMAL_FONT));
            stayCell.addElement(new Paragraph("Check-In: " + formatDate(res.getCheckIn()), NORMAL_FONT));
            stayCell.addElement(new Paragraph("Check-Out: " + formatDate(res.getCheckOut()), NORMAL_FONT));
            infoTable.addCell(stayCell);

            document.add(infoTable);

            // --- 4. Billing Table ---
            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(100);
            table.setWidths(new float[] { 4f, 2f, 2f, 2f });
            table.setSpacingBefore(10f);

            // Table Headers
            String[] headers = { "Description", "Rate (LKR)", "Qty / Nights", "Amount (LKR)" };
            for (String header : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(header, TH_FONT));
                cell.setBackgroundColor(PRIMARY_COLOR);
                cell.setPadding(10f);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setBorderColor(BaseColor.WHITE);
                table.addCell(cell);
            }

            int nights = calculateNights(res.getCheckIn(), res.getCheckOut());
            double baseTotal = res.getTotalCost();
            double roomRate = baseTotal / nights;

            // Row 1: Room Charge
            addTableRow(table,
                    (res.getRoomType() != null ? res.getRoomType() : "Standard") + " Room (Room #" + res.getRoomId()
                            + ")",
                    roomRate, nights, baseTotal, true);

            // Row 2: Services
            if (res.getServices() != null && !res.getServices().trim().isEmpty() && !res.getServices().equals("None")) {
                addTableRow(table, "Extra Services: " + res.getServices(), 0, 1, 0, false);
            }

            document.add(table);

            // --- 5. Totals Section ---
            PdfPTable totalsTable = new PdfPTable(2);
            totalsTable.setWidthPercentage(45);
            totalsTable.setHorizontalAlignment(Element.ALIGN_RIGHT);
            totalsTable.setSpacingBefore(20f);

            double subtotal = baseTotal;
            double taxRate = 0.15;
            double taxAmount = subtotal * taxRate;
            double grandTotal = subtotal + taxAmount;

            addTotalRow(totalsTable, "Subtotal:", subtotal, NORMAL_FONT);
            addTotalRow(totalsTable, "Taxes & Fees (15%):", taxAmount, NORMAL_FONT);

            // Grand Total Row
            PdfPCell lblCell = new PdfPCell(new Phrase("GRAND TOTAL:", GRAND_TOTAL_FONT));
            lblCell.setBorder(Rectangle.TOP);
            lblCell.setBorderWidthTop(2f);
            lblCell.setBorderColorTop(PRIMARY_COLOR);
            lblCell.setPaddingTop(12f);
            lblCell.setPaddingBottom(5f);
            lblCell.setHorizontalAlignment(Element.ALIGN_LEFT);
            totalsTable.addCell(lblCell);

            PdfPCell valCell = new PdfPCell(new Phrase(String.format("LKR %,.2f", grandTotal), GRAND_TOTAL_FONT));
            valCell.setBorder(Rectangle.TOP);
            valCell.setBorderWidthTop(2f);
            valCell.setBorderColorTop(PRIMARY_COLOR);
            valCell.setPaddingTop(12f);
            valCell.setPaddingBottom(5f);
            valCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            totalsTable.addCell(valCell);

            document.add(totalsTable);

            // --- 6. Footer ---
            document.add(new Paragraph("\n\n"));
            LineSeparator footerLs = new LineSeparator(0.5f, 100, BaseColor.GRAY, Element.ALIGN_CENTER, -20);
            document.add(new Chunk(footerLs));

            Paragraph footer = new Paragraph(
                    "\nThank you for choosing Ocean View Resort. We hope you had a pleasant stay!\nTerms & Conditions apply. All prices include applicable local taxes where noted.",
                    FOOTER_FONT);
            footer.setAlignment(Element.ALIGN_CENTER);
            footer.setSpacingBefore(10f);
            document.add(footer);

            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void addTableRow(PdfPTable table, String desc, double rate, int qty, double amount, boolean isHighlight) {
        BaseColor bgColor = isHighlight ? LIGHT_GRAY : BaseColor.WHITE;

        PdfPCell c1 = new PdfPCell(new Phrase(desc, NORMAL_FONT));
        c1.setBackgroundColor(bgColor);
        c1.setPadding(10f);
        c1.setBorderColor(BaseColor.LIGHT_GRAY);
        table.addCell(c1);

        PdfPCell c2 = new PdfPCell(new Phrase(rate > 0 ? String.format("%,.2f", rate) : "-", NORMAL_FONT));
        c2.setBackgroundColor(bgColor);
        c2.setPadding(10f);
        c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
        c2.setBorderColor(BaseColor.LIGHT_GRAY);
        table.addCell(c2);

        PdfPCell c3 = new PdfPCell(new Phrase(String.valueOf(qty), NORMAL_FONT));
        c3.setBackgroundColor(bgColor);
        c3.setPadding(10f);
        c3.setHorizontalAlignment(Element.ALIGN_CENTER);
        c3.setBorderColor(BaseColor.LIGHT_GRAY);
        table.addCell(c3);

        PdfPCell c4 = new PdfPCell(new Phrase(amount > 0 ? String.format("%,.2f", amount) : "-", NORMAL_FONT));
        c4.setBackgroundColor(bgColor);
        c4.setPadding(10f);
        c4.setHorizontalAlignment(Element.ALIGN_RIGHT);
        c4.setBorderColor(BaseColor.LIGHT_GRAY);
        table.addCell(c4);
    }

    private void addTotalRow(PdfPTable table, String label, double amount, Font font) {
        PdfPCell lCell = new PdfPCell(new Phrase(label, font));
        lCell.setBorder(Rectangle.NO_BORDER);
        lCell.setPadding(5f);
        table.addCell(lCell);

        PdfPCell rCell = new PdfPCell(new Phrase(String.format("LKR %,.2f", amount), font));
        rCell.setBorder(Rectangle.NO_BORDER);
        rCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        rCell.setPadding(5f);
        table.addCell(rCell);
    }

    private String formatDate(Date date) {
        if (date == null)
            return "N/A";
        return new SimpleDateFormat("dd MMM yyyy").format(date);
    }

    private int calculateNights(Date in, Date out) {
        if (in == null || out == null)
            return 1;
        long diff = out.getTime() - in.getTime();
        int days = (int) (diff / (1000 * 60 * 60 * 24));
        return days > 0 ? days : 1;
    }
}
