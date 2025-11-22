// ========================================
// WAOW Season 6 - Main JavaScript
// ========================================

const API_BASE_URL = 'http://127.0.0.1:5000/api/admin';

// ========================================
// Load Statistics on Landing Page
// ========================================
async function loadStats() {
    try {
        // Load customer stats
        const customersResponse = await fetch(`${API_BASE_URL}/customers/stats`);
        const customersData = await customersResponse.json();
        
        if (customersData.success) {
            document.getElementById('totalCustomers').textContent = 
                customersData.data.total_customers || 0;
        }

        // Load products count
        const productsResponse = await fetch(`${API_BASE_URL}/products/`);
        const productsData = await productsResponse.json();
        
        if (productsData.success) {
            document.getElementById('totalProducts').textContent = 
                productsData.total || 0;
        }

        // Load transaction stats
        const transactionsResponse = await fetch(`${API_BASE_URL}/transactions/stats`);
        const transactionsData = await transactionsResponse.json();
        
        if (transactionsData.success) {
            const stats = transactionsData.data;
            document.getElementById('totalTransactions').textContent = 
                stats.total_transactions || 0;
            document.getElementById('totalRevenue').textContent = 
                `$${(stats.total_revenue || 0).toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2})}`;
        }

    } catch (error) {
        console.error('Error loading stats:', error);
        // Show placeholder if API fails
        document.getElementById('totalCustomers').textContent = '--';
        document.getElementById('totalProducts').textContent = '--';
        document.getElementById('totalTransactions').textContent = '--';
        document.getElementById('totalRevenue').textContent = '--';
    }
}

// ========================================
// Log Out from Landing Page
// ========================================
function handleLogout() {
    if (confirm('Are you sure you want to log out?')) {
        localStorage.clear();
        sessionStorage.clear();
        showToast('Logged out successfully!', 'success');
        
        setTimeout(() => {
            // just to make sure :)
            localStorage.removeItem("user");
            window.location.href = '/auth/login';
        }, 1000);
    }
}


// ========================================
// Initialize on Page Load
// ========================================
document.addEventListener('DOMContentLoaded', function() {
    // Load stats
    loadStats();
    
    // Add smooth scroll behavior
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
});

// ========================================
// Utility Functions
// ========================================

/**
 * Format date to readable string
 */
function formatDate(dateString) {
    if (!dateString) return 'N/A';
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
}

/**
 * Format currency
 */
function formatCurrency(amount) {
    return `$${parseFloat(amount).toLocaleString('en-US', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    })}`;
}

/**
 * Show toast notification
 */
function showToast(message, type = 'success') {
    // Create toast element
    const toastHtml = `
        <div class="toast align-items-center text-white bg-${type} border-0 position-fixed top-0 end-0 m-3" role="alert" style="z-index: 9999;">
            <div class="d-flex">
                <div class="toast-body">
                    ${message}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        </div>
    `;
    
    // Add to body
    document.body.insertAdjacentHTML('beforeend', toastHtml);
    
    // Initialize and show toast
    const toastElement = document.querySelector('.toast:last-child');
    const toast = new bootstrap.Toast(toastElement, { delay: 3000 });
    toast.show();
    
    // Remove from DOM after hidden
    toastElement.addEventListener('hidden.bs.toast', function() {
        toastElement.remove();
    });
}

/**
 * Show loading spinner in element
 */
function showLoading(elementId) {
    const element = document.getElementById(elementId);
    if (element) {
        element.innerHTML = `
            <tr>
                <td colspan="100" class="text-center py-5">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="mt-2 text-muted">Loading data...</p>
                </td>
            </tr>
        `;
    }
}

/**
 * Show no data message
 */
function showNoData(elementId, message = 'No data available') {
    const element = document.getElementById(elementId);
    if (element) {
        element.innerHTML = `
            <tr>
                <td colspan="100" class="text-center py-5">
                    <i class="bi bi-inbox fs-1 text-muted"></i>
                    <p class="mt-2 text-muted">${message}</p>
                </td>
            </tr>
        `;
    }
}

/**
 * Handle API errors
 */
function handleAPIError(error, defaultMessage = 'An error occurred') {
    console.error('API Error:', error);
    showToast(defaultMessage, 'danger');
}
