// ========================================
// WAOW Season 6 - Products JavaScript
// ========================================

const API_BASE_URL = 'http://127.0.0.1:5000/api/admin';

// ========================================
// Load Products
// ========================================
async function loadProducts() {
    try {
        const response = await fetch(`${API_BASE_URL}/products/`);
        const data = await response.json();
        
        const tableBody = document.getElementById('productsTableBody');
        
        if (data.success && data.data.length > 0) {
            tableBody.innerHTML = data.data.map(product => `
                <tr>
                    <td>${product.ProductID}</td>
                    <td><strong>${product.ProductName}</strong></td>
                    <td>
                        <span class="badge bg-secondary">${product.CategoryName || 'N/A'}</span>
                    </td>
                    <td class="fw-bold text-success">$${parseFloat(product.Price).toFixed(2)}</td>
                    <td>${product.Stock}</td>
                    <td>
                        ${getStockBadge(product.Stock)}
                    </td>
                    <td>${formatDate(product.created_at)}</td>
                    <td class="text-center">
                        <button class="btn btn-sm btn-warning" onclick="openEditModal(${product.ProductID})">
                            <i class="bi bi-pencil"></i>
                        </button>
                        <button class="btn btn-sm btn-danger" onclick="deleteProduct(${product.ProductID})">
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
                        <p class="mt-2 text-muted">No products found</p>
                    </td>
                </tr>
            `;
        }
        
    } catch (error) {
        console.error('Error loading products:', error);
        showToast('Failed to load products', 'danger');
    }
}

// ========================================
// Load Categories
// ========================================
async function loadCategories() {
    try {
        const response = await fetch(`${API_BASE_URL}/products/categories`);
        const data = await response.json();
        
        if (data.success) {
            const categories = data.data;
            
            // Populate category dropdowns
            const addCategorySelect = document.getElementById('addCategory');
            const editCategorySelect = document.getElementById('editCategory');
            const filterCategorySelect = document.getElementById('filterCategory');
            
            const categoryOptions = categories.map(cat => 
                `<option value="${cat.CategoryID}">${cat.Name}</option>`
            ).join('');
            
            addCategorySelect.innerHTML = '<option value="">Select Category</option>' + categoryOptions;
            editCategorySelect.innerHTML = categoryOptions;
            filterCategorySelect.innerHTML = '<option value="">All Categories</option>' + categoryOptions;
        }
    } catch (error) {
        console.error('Error loading categories:', error);
    }
}

// ========================================
// Add New Product
// ========================================
async function addProduct() {
    const name = document.getElementById('addName').value;
    const categoryId = document.getElementById('addCategory').value;
    const price = document.getElementById('addPrice').value;
    const stock = document.getElementById('addStock').value;
    
    if (!name || !categoryId || !price || !stock) {
        showToast('Please fill all fields', 'warning');
        return;
    }
    
    try {
        const response = await fetch(`${API_BASE_URL}/products/`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                Name: name,
                CategoryID: parseInt(categoryId),
                Price: parseFloat(price),
                Stock: parseInt(stock)
            })
        });
        
        const data = await response.json();
        
        if (data.success) {
            showToast('Product added successfully!', 'success');
            
            // Close modal
            const modal = bootstrap.Modal.getInstance(document.getElementById('addProductModal'));
            modal.hide();
            
            // Reset form
            document.getElementById('addProductForm').reset();
            
            // Reload data
            loadProducts();
        } else {
            showToast('Failed to add product', 'danger');
        }
    } catch (error) {
        console.error('Error adding product:', error);
        showToast('Failed to add product', 'danger');
    }
}

// ========================================
// Open Edit Modal
// ========================================
async function openEditModal(productId) {
    try {
        const response = await fetch(`${API_BASE_URL}/products/${productId}`);
        const data = await response.json();
        
        if (data.success) {
            const product = data.data;
            
            document.getElementById('editProductId').value = product.ProductID;
            document.getElementById('editName').value = product.ProductName;
            document.getElementById('editCategory').value = product.CategoryID;
            document.getElementById('editPrice').value = product.Price;
            document.getElementById('editStock').value = product.Stock;
            
            // Show modal
            const modal = new bootstrap.Modal(document.getElementById('editProductModal'));
            modal.show();
        }
    } catch (error) {
        console.error('Error loading product:', error);
        showToast('Failed to load product data', 'danger');
    }
}

// ========================================
// Update Product
// ========================================
async function updateProduct() {
    const productId = document.getElementById('editProductId').value;
    const name = document.getElementById('editName').value;
    const categoryId = document.getElementById('editCategory').value;
    const price = document.getElementById('editPrice').value;
    const stock = document.getElementById('editStock').value;
    
    try {
        const response = await fetch(`${API_BASE_URL}/products/${productId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                Name: name,
                CategoryID: parseInt(categoryId),
                Price: parseFloat(price),
                Stock: parseInt(stock)
            })
        });
        
        const data = await response.json();
        
        if (data.success) {
            showToast('Product updated successfully!', 'success');
            
            // Close modal
            const modal = bootstrap.Modal.getInstance(document.getElementById('editProductModal'));
            modal.hide();
            
            // Reload data
            loadProducts();
        } else {
            showToast('Failed to update product', 'danger');
        }
    } catch (error) {
        console.error('Error updating product:', error);
        showToast('Failed to update product', 'danger');
    }
}

// ========================================
// Delete Product
// ========================================
async function deleteProduct(productId) {
    if (!confirm('Are you sure you want to delete this product?')) {
        return;
    }
    
    try {
        const response = await fetch(`${API_BASE_URL}/products/${productId}`, {
            method: 'DELETE'
        });
        
        const data = await response.json();
        
        if (data.success) {
            showToast('Product deleted successfully!', 'success');
            loadProducts();
        } else {
            showToast('Failed to delete product', 'danger');
        }
    } catch (error) {
        console.error('Error deleting product:', error);
        showToast('Failed to delete product', 'danger');
    }
}

// ========================================
// Reset Filters
// ========================================
function resetFilters() {
    document.getElementById('filterCategory').value = '';
    document.getElementById('filterStock').value = '';
    loadProducts();
}

// ========================================
// Utility Functions
// ========================================

function getStockBadge(stock) {
    if (stock === 0) {
        return '<span class="badge bg-danger">Out of Stock</span>';
    } else if (stock < 10) {
        return '<span class="badge bg-warning">Low Stock</span>';
    } else {
        return '<span class="badge bg-success">Available</span>';
    }
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
// Initialize on Page Load
// ========================================
document.addEventListener('DOMContentLoaded', function() {
    loadProducts();
    loadCategories();
});
