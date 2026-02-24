/**
 * Ocean View Theme Switcher Logic
 * Handles persistence and dynamic stylesheet injection
 */

(function() {
    // 1. Initial Load Logic (Blocking to prevent FOUC)
    const savedTheme = localStorage.getItem('ocean-view-theme') || 'light';
    const themeLink = document.getElementById('theme-link');
    
    if (themeLink) {
        const themePath = `css/${savedTheme}-theme.css`;
        if (themeLink.getAttribute('href') !== themePath) {
            themeLink.setAttribute('href', themePath);
        }
    }

    // 2. Global Event Listeners
    document.addEventListener('DOMContentLoaded', () => {
        updateToggleButton(savedTheme);
        
        // Listen for theme toggle clicks
        document.body.addEventListener('click', (e) => {
            const btn = e.target.closest('#theme-toggle');
            if (btn) {
                toggleTheme();
            }
        });
    });

    function toggleTheme() {
        const currentTheme = localStorage.getItem('ocean-view-theme') || 'light';
        const newTheme = currentTheme === 'light' ? 'dark' : 'light';
        
        localStorage.setItem('ocean-view-theme', newTheme);
        
        const themeLink = document.getElementById('theme-link');
        if (themeLink) {
            themeLink.setAttribute('href', `css/${newTheme}-theme.css`);
        }
        
        updateToggleButton(newTheme);
        
        // Add a nice ripple effect or transition hint
        document.documentElement.classList.add('theme-transitioning');
        setTimeout(() => {
            document.documentElement.classList.remove('theme-transitioning');
        }, 500);
    }

    function updateToggleButton(theme) {
        const btn = document.getElementById('theme-toggle');
        if (btn) {
            const icon = btn.querySelector('i');
            if (icon) {
                icon.className = theme === 'light' ? 'fas fa-moon' : 'fas fa-sun';
            }
            btn.title = `Switch to ${theme === 'light' ? 'Dark' : 'Light'} Mode`;
        }
    }
})();
