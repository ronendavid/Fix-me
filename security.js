/**
 * Security: Frame Buster
 * Prevents the site from being potentially loaded inside an iframe (Clickjacking protection).
 * Note: For stronger protection, configure the server to send 'X-Frame-Options: SAMEORIGIN' 
 * or 'Content-Security-Policy: frame-ancestors 'self'' headers.
 */
if (window.self !== window.top) {
    try {
        window.top.location = window.self.location;
    } catch (e) {
        // Fallback or suppression if blocked
    }
}