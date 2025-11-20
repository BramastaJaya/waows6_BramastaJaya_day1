// ========================================
// WAOW Season 6 - Transactions JavaScript
// ========================================

const API_BASE_URL = 'http://127.0.0.1:5000/api';

// ========================================
// Load Recent Transactions
// ========================================
async function loadTransactions() {
    try {
        const response = await fetch(`${API_BASE_URL}/transactions/recent`);
        const data = await response.json();
        
        const tableBody = document.getElementById('transactionsTableBody');
        
        if (data.success && data.data.length > 0) {
            tableBody.innerHTML = data.data.map(transaction => `
                <tr>
                    <td><strong>#${transaction.TransactionID}</strong></td>
                    <td>${transaction.CustomerID}</td>
                    <td>
                        <i class="bi bi-${transaction.Gender === 'Male' ? 'gender-male text-primary' : 'gender-female text-danger'}"></i>
                        ${transaction.Gender}
                    </td>
                    <td>${transaction.Age}</td>
                    <td class="fw-bold text-success">$${parseFloat(transaction.TotalAmount).toFixed(2)}</td>
                    <td>
                        <span class="badge bg-info">${transaction.PaymentMethod || 'N/A'}</span>
                    </td>
                    <td>${formatDateTime(transaction.TransactionDate)}</td>
                    <td class="text-center">
                        <button class="btn btn-sm btn-info" onclick="viewTransactionDetail(${transaction.TransactionID})">
                            <i class="bi bi-eye"></i> View
                        </button>
                    </td>
                </tr>
            `).join('');
        } else {
            tableBody.innerHTML = `
                <tr>
                    <td colspan="8" class="text-center py-5">
                        <i class="bi bi-inbox fs-1 text-muted"></i>
                        <p class="mt-2 text-muted">No transactions found</p>
                    </td>
                </tr>
            `;
        }
        
    } catch (error) {
        console.error('Error loading transactions:', error);
        showToast('Failed to load transactions', 'danger');
    }
}

// ========================================
// Load Transaction Statistics
// ========================================
async function loadStats() {
    try {
        const response = await fetch(`${API_BASE_URL}/transactions/stats`);
        const data = await response.json();
        
        if (data.success) {
            const stats = data.data;
            document.getElementById('statTotalTransactions').textContent = stats.total_transactions || 0;
            document.getElementById('statTotalRevenue').textContent = formatCurrency(stats.total_revenue || 0);
            document.getElementById('statAvgTransaction').textContent = formatCurrency(stats.avg_transaction_value || 0);
            document.getElementById('statMaxTransaction').textContent = formatCurrency(stats.max_transaction || 0);
        }
    } catch (error) {
        console.error('Error loading stats:', error);
    }
}

// ========================================
// Load Top Customers
// ========================================
async function loadTopCustomers() {
    try {
        const response = await fetch(`${API_BASE_URL}/transactions/top-customers`);
        const data = await response.json();
        
        const tableBody = document.getElementById('topCustomersTableBody');
        
        if (data.success && data.data.length > 0) {
            tableBody.innerHTML = data.data.map((customer, index) => `
                <tr>
                    <td>
                        <span class="badge ${getRankBadge(index + 1)}">#${index + 1}</span>
                    </td>
                    <td>${customer.CustomerID}</td>
                    <td>
                        <i class="bi bi-${customer.Gender === 'Male' ? 'gender-male text-primary' : 'gender-female text-danger'}"></i>
                        ${customer.Gender}
                    </td>
                    <td>${customer.Age}</td>
                    <td>$${customer.Annual_Income}K</td>
                    <td>
                        <span class="badge bg-info">${customer.total_transactions || 0}</span>
                    </td>
                    <td class="fw-bold text-success">${formatCurrency(customer.total_spent || 0)}</td>
                </tr>
            `).join('');
        } else {
            tableBody.innerHTML = `
                <tr>
                    <td colspan="7" class="text-center py-5">
                        <i class="bi bi-inbox fs-1 text-muted"></i>
                        <p class="mt-2 text-muted">No customer data available</p>
                    </td>
                </tr>
            `;
        }
        
    } catch (error) {
        console.error('Error loading top customers:', error);
    }
}

// ========================================
// View Transaction Detail
// ========================================
async function viewTransactionDetail(transactionId) {
    try {
        const response = await fetch(`${API_BASE_URL}/transactions/${transactionId}`);
        const data = await response.json();
        
        if (data.success) {
            const transaction = data.data;
            const items = transaction.items || [];
            
            const detailHTML = `
                <div class="row mb-4">
                    <div class="col-md-6">
                        <h6 class="fw-bold mb-3">Transaction Information</h6>
                        <table class="table table-sm">
                            <tr>
                                <td class="text-muted">Transaction ID:</td>
                                <td><strong>#${transaction.TransactionID}</strong></td>
                            </tr>
                            <tr>
                                <td class="text-muted">Date:</td>
                                <td>${formatDateTime(transaction.TransactionDate)}</td>
                            </tr>
                            <tr>
                                <td class="text-muted">Payment Method:</td>
                                <td><span class="badge bg-info">${transaction.PaymentMethod || 'N/A'}</span></td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <h6 class="fw-bold mb-3">Customer Information</h6>
                        <table class="table table-sm">
                            <tr>
                                <td class="text-muted">Customer ID:</td>
                                <td><strong>${transaction.CustomerID}</strong></td>
                            </tr>
                            <tr>
                                <td class="text-muted">Gender:</td>
                                <td>${transaction.Gender}</td>
                            </tr>
                            <tr>
                                <td class="text-muted">Age:</td>
                                <td>${transaction.Age} years</td>
                            </tr>
                            <tr>
                                <td class="text-muted">Annual Income:</td>
                                <td>$${transaction.Annual_Income}K</td>
                            </tr>
                        </table>
                    </div>
                </div>
                
                <h6 class="fw-bold mb-3">Items Purchased</h6>
                <div class="table-responsive">
                    <table class="table table-sm table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Product</th>
                                <th class="text-center">Quantity</th>
                                <th class="text-end">Unit Price</th>
                                <th class="text-end">Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${items.map(item => `
                                <tr>
                                    <td>${item.ProductName}</td>
                                    <td class="text-center">${item.Quantity}</td>
                                    <td class="text-end">${formatCurrency(item.UnitPrice)}</td>
                                    <td class="text-end fw-bold">${formatCurrency(item.Subtotal)}</td>
                                </tr>
                            `).join('')}
                        </tbody>
                        <tfoot class="table-light">
                            <tr>
                                <td colspan="3" class="text-end fw-bold">TOTAL:</td>
                                <td class="text-end fw-bold text-success fs-5">${formatCurrency(transaction.TotalAmount)}</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            `;
            
            document.getElementById('transactionDetailContent').innerHTML = detailHTML;
            
            // Show modal
            const modal = new bootstrap.Modal(document.getElementById('transactionDetailModal'));
            modal.show();
        }
    } catch (error) {
        console.error('Error loading transaction detail:', error);
        showToast('Failed to load transaction details', 'danger');
    }
}

// ========================================
// Utility Functions
// ========================================

function getRankBadge(rank) {
    if (rank === 1) return 'bg-warning';
    if (rank === 2) return 'bg-secondary';
    if (rank === 3) return 'bg-danger';
    return 'bg-primary';
}

function formatCurrency(amount) {
    return `$${parseFloat(amount).toLocaleString('en-US', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    })}`;
}

function formatDateTime(dateString) {
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

function showToast(message, type = 'success') {
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
    
    document.body.insertAdjacentHTML('beforeend', toastHtml);
    const toastElement = document.querySelector('.toast:last-child');
    const toast = new bootstrap.Toast(toastElement, { delay: 3000 });
    toast.show();
    
    toastElement.addEventListener('hidden.bs.toast', function() {
        toastElement.remove();
    });
}

// ========================================
// Initialize on Page Load
// ========================================
document.addEventListener('DOMContentLoaded', function() {
    loadTransactions();
    loadStats();
    loadTopCustomers();
});
