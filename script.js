/**
 * ניהול מצב לילה (Dark Mode)
 */
function toggleDarkMode() {
    document.documentElement.classList.toggle('dark');
    const icon = document.getElementById('theme-icon');
    if (document.documentElement.classList.contains('dark')) {
        icon.className = 'fas fa-sun';
    } else {
        icon.className = 'fas fa-moon';
    }
}

/**
 * אנימציית מספרים רצים (Counters)
 */
const startCount = (counter) => {
    const target = parseFloat(counter.getAttribute('data-target'));
    const isDecimal = counter.getAttribute('data-decimal') === 'true';
    const speed = 100;
    let count = 0;
    const inc = target / speed;

    const update = () => {
        count += inc;
        if (count < target) {
            counter.innerText = isDecimal ? count.toFixed(1) : Math.floor(count);
            setTimeout(update, 20);
        } else {
            counter.innerText = isDecimal ? target : target;
        }
    };
    update();
};

/**
 * מעקב אחרי כניסה של אלמנטים למסך (Intersection Observer)
 */
const observerOptions = {
    threshold: 0.8
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            const counter = entry.target;
            if (!counter.classList.contains('animated')) {
                startCount(counter);
                counter.classList.add('animated');
            }
        }
    });
}, observerOptions);

/**
 * הפעלה ראשונית
 */
window.addEventListener('DOMContentLoaded', () => {
    // אתחול המונים
    const counters = document.querySelectorAll('.counter-num');
    counters.forEach(c => observer.observe(c));

    // עדכון שנה נוכחית בפוטר
    const yearElement = document.getElementById('year');
    if (yearElement) {
        yearElement.textContent = new Date().getFullYear();
    }
});