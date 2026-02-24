<style>
    .footer {
        background-color: rgba(17, 17, 17, 0.75);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        color: var(--text-secondary, #aaa);
        text-align: center;
        padding: 15px 10px;
        margin-top: auto;
        font-size: 0.9rem;
        width: 100%;
        box-sizing: border-box;
        border-top: 1px solid rgba(255, 255, 255, 0.05);
    }

    .footer-content {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 5px;
    }

    .footer-logo {
        font-size: 1.2rem;
        color: white;
        font-weight: 600;
        letter-spacing: 1px;
        margin-bottom: 5px;
    }

    .footer-icons {
        margin-top: 5px;
        font-size: 1.3rem;
    }

    .footer-icons i {
        margin: 0 12px;
        cursor: pointer;
        color: var(--text-secondary, #aaa);
        transition: color 0.3s ease, transform 0.3s ease;
    }

    .footer-icons i:hover {
        color: var(--accent-light, #3498db);
        transform: translateY(-3px);
    }
</style>

<footer class="footer">
    <div class="footer-content">
        <div>
            <div class="footer-logo">
                <i class="fas fa-water" style="color: var(--accent-light); margin-right: 8px;"></i>
                Ocean View Resort
            </div>
            &copy; <%= java.util.Calendar.getInstance().get(java.util.Calendar.YEAR) %> All Rights Reserved.<br>
                <span style="font-style: italic; opacity: 0.8; font-size: 0.85rem;">A Touch of Paradise</span>
        </div>
        <div class="footer-icons">
            <i class="fab fa-facebook"></i>
            <i class="fab fa-twitter"></i>
            <i class="fab fa-instagram"></i>
        </div>
    </div>
</footer>