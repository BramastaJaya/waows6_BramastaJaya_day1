// ========================================
// WAOW Season 6 - Customers JavaScript
// ========================================

const API_BASE_URL = 'http://127.0.0.1:5000/api/admin';

// ========================================
// Load Customers
// ========================================
async function loadCustomers() {
    try {
        const response = await fetch(`${API_BASE_URL}/customers/`);
        const data = await response.json();
        
        const tableBody = document.getElementById('customersTableBody');
        
        if (data.success && data.data.length > 0) {
            tableBody.innerHTML = data.data.map(customer => `
                <tr>
                    <td>${customer.CustomerID}</td>
                    <td>${customer.Name}</td>
                    <td>
                        <i class="bi bi-${customer.Gender === 'Male' ? 'gender-male text-primary' : 'gender-female text-danger'}"></i>
                        ${customer.Gender}
                    </td>
                    <td>${customer.Age}</td>
                    <td>$${customer.Annual_Income}</td>
                    <td>
                        <span class="badge bg-${getSpendingColor(customer.Spending_Score)}">
                            ${customer.Spending_Score}/100
                        </span>
                    </td>
                    <td>${formatDate(customer.created_at)}</td>
                    <td class="text-center">
                        <button class="btn btn-sm btn-warning" onclick="openEditModal(${customer.CustomerID})">
                            <i class="bi bi-pencil"></i>
                        </button>
                        <button class="btn btn-sm btn-danger" onclick="deleteCustomer(${customer.CustomerID})">
                            <i class="bi bi-trash"></i>
                        </button>
                    </td>
                </tr>
            `).join('');
        } else {
            tableBody.innerHTML = `
                <tr>
                    <td colspan="8" class="text-center py-5">
                        <i class="bi bi-inbox fs-1 text-muted"></i>
                        <p class="mt-2 text-muted">No customers found</p>
                    </td>
                </tr>
            `;
        }
        
    } catch (error) {
        console.error('Error loading customers:', error);
        showToast('Failed to load customers', 'danger');
    }
}

// ========================================
// Load Customer Statistics
// ========================================
async function loadStats() {
    try {
        const response = await fetch(`${API_BASE_URL}/customers/stats`);
        const data = await response.json();
        
        if (data.success) {
            const stats = data.data;
            document.getElementById('statTotalCustomers').textContent = stats.total_customers || 0;
            document.getElementById('statAvgIncome').textContent = `$${Math.round(stats.avg_income || 0)}K`;
            document.getElementById('statAvgSpending').textContent = Math.round(stats.avg_spending_score || 0);
            document.getElementById('statAvgAge').textContent = Math.round(stats.avg_age || 0);
        }
    } catch (error) {
        console.error('Error loading stats:', error);
    }
}

// ========================================
// Add New Customer
// ========================================
async function addCustomer() {
    const name = document.getElementById('addName').value;
    const email = document.getElementById('addEmail').value;
    const password = document.getElementById('addPassword').value;
    const gender = document.getElementById('addGender').value;
    const year = document.getElementById('Year').value;
    const month = document.getElementById('Month').value;
    const day = document.getElementById('Day').value;
    const roleId = document.getElementById('addRole').value;
    const income = document.getElementById('addIncome').value;
    const spending = document.getElementById('addSpending').value;

    if (!name || !email || !password || !gender || !year || !month || !day || !roleId || !income || !spending) {
        showToast('Please fill all the requirements', 'warning');
        return;
    }

    const dateOfBirth = `${year}-${month}-${day}`;

    try {
        const response = await fetch(`${API_BASE_URL}/customers/`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                Name: name,
                Email: email,
                Password: password,
                Gender: gender,
                DateofBirth: dateOfBirth,
                RoleId: parseInt(roleId),
                Annual_Income: parseInt(income),
                Spending_Score: parseInt(spending)
            })
        });

        const data = await response.json();

        if (data.success) {
            showToast('Customer added successfully!', 'success');

            const modal = bootstrap.Modal.getInstance(document.getElementById('addCustomerModal'));
            modal.hide();

            document.getElementById('addCustomerForm').reset();

            loadCustomers();
            loadStats();
        } else {
            showToast(data.error || 'Failed to add customer, try again', 'danger');
        }

    } catch (error) {
        console.error('Error adding customer:', error);
        showToast('Failed to add customer', 'danger');
    }
}


// ========================================
// Open Edit Modal
// ========================================
async function openEditModal(customerId) {
    try {
        const response = await fetch(`${API_BASE_URL}/customers/${customerId}`);
        const data = await response.json();
        const customer = data.data;
        document.getElementById('editCustomerId').value = customer.CustomerID;
        document.getElementById('editName').value = customer.Name || '';
        document.getElementById('editRoleId').value = customer.RoleId;
        document.getElementById('editGender').value = customer.Gender;      
        document.getElementById('editIncome').value = customer.Annual_Income || 0;
        document.getElementById('editSpending').value = customer.Spending_Score || 1;
        const modal = new bootstrap.Modal(document.getElementById('editCustomerModal'));
        modal.show();
    } catch (error) {
        console.error('Error loading customer:', error);
        showToast('Customer not exist?', 'danger');
    }
}

// ========================================
// Update Customer
// ========================================
async function updateCustomer() {
    const customerId = document.getElementById('editCustomerId').value;
    const name = document.getElementById('editName').value;
    const gender = document.getElementById('editGender').value;
    const roleId = document.getElementById('editRoleId').value;
    const income = document.getElementById('editIncome').value;
    const spending = document.getElementById('editSpending').value;

    try {
        const response = await fetch(`${API_BASE_URL}/customers/${customerId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                Name: name,
                Gender: gender,
                RoleId: parseInt(roleId),
                Annual_Income: parseInt(income),
                Spending_Score: parseInt(spending)
            })
        });
        
        const data = await response.json();
        
        if (data.success) {
            showToast('Customer updated successfully!', 'success');    
            const modal = bootstrap.Modal.getInstance(document.getElementById('editCustomerModal'));
            modal.hide();
            
            loadCustomers();
            loadStats();
        } else {
            showToast(data.error || 'Failed to update the customer', 'warning');
        }
    } catch (error) {
        console.error('Error updating customer:', error);
        showToast('Failed to process customers data', 'danger');
    }
}

// ========================================
// Delete Customer
// ========================================
async function deleteCustomer(customerId) {
    if (!confirm('Are you sure you want to delete this customer?')) {
        return;
    }
    
    try {
        const response = await fetch(`${API_BASE_URL}/customers/${customerId}`, {
            method: 'DELETE'
        });
        
        const data = await response.json();
        
        if (data.success) {
            showToast('Customer deleted successfully!', 'success');
            loadCustomers();
            loadStats();
        } else {
            showToast('Failed to delete customer', 'danger');
        }
    } catch (error) {
        console.error('Error deleting customer:', error);
        showToast('Failed to delete customer', 'danger');
    }
}

// ========================================
// Utility Functions
// ========================================

function getSpendingColor(score) {
    if (score >= 75) return 'success';
    if (score >= 50) return 'info';
    if (score >= 25) return 'warning';
    return 'danger';
}

function formatDate(dateString) {
    if (!dateString) return 'N/A';
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric'
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
// Initialize Year Select Options
// ========================================
function initYearSelect() {
    const yearSelect = document.getElementById('editYear');
    const currentYear = new Date().getFullYear();
    
    // Clear existing options except the first placeholder
    yearSelect.innerHTML = '<option value="" disabled selected hidden>Select</option>';
    
    // Add years from current year to 1940
    for (let y = currentYear; y >= 1940; y--) {
        yearSelect.innerHTML += `<option value="${y}">${y}</option>`;
    }
}

// ========================================
// Initialize on Page Load
// ========================================
document.addEventListener('DOMContentLoaded', function() {
    loadCustomers();
    loadStats();
    initYearSelect();
});