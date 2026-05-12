import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product = Product(
    id: '1',
    name: 'iPhone 14 Pro',
    sku: 'IP14P-256-SP',
    price: 999.99,
    originalPrice: 1199.99,
    brand: 'Apple',
    category: 'Smartphones',
    model: 'A2890',
    color: 'Space Black',
    condition: 'New',
    storage: '256GB',
    ram: '6GB',
    processor: 'A16 Bionic',
    battery: '3200 mAh',
    osVersion: 'iOS 17',
    warranty: '1 Year',
    quantity: 15,
    soldCount: 42,
    description:
    'The iPhone 14 Pro features a stunning Super Retina XDR display, ProMotion technology, and the advanced A16 Bionic chip. With a 48MP main camera and improved low-light performance, it takes professional-quality photos and videos.',
    isAvailable: true,
    isActive: true,
    imageUrl: 'https://example.com/iphone14pro.jpg',
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
    updatedAt: DateTime.now(),
  );

  ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editProduct(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteProduct(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Section
            _buildImageSection(),

            // Product Info Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Status
                  _buildTitleSection(),
                  const SizedBox(height: 16),

                  // Price Section
                  _buildPriceSection(),
                  const SizedBox(height: 24),

                  // Product Details
                  _buildDetailsSection(),
                  const SizedBox(height: 24),

                  // Specifications
                  _buildSpecificationsSection(),
                  const SizedBox(height: 24),

                  // Inventory Info
                  _buildInventorySection(),
                  const SizedBox(height: 24),

                  // Description
                  _buildDescriptionSection(),
                  const SizedBox(height: 24),

                  // Actions
                  _buildActionButtons(context),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: product.imageUrl != null
          ? Image.network(
              product.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholder();
              },
            )
          : _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.image_outlined, size: 80, color: Colors.grey.shade400),
        const SizedBox(height: 8),
        Text(
          'No Image Available',
          style: TextStyle(color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'SKU: ${product.sku}',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: product.isAvailable ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            product.isAvailable ? 'In Stock' : 'Out of Stock',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
          if (product.originalPrice != null &&
              product.originalPrice! > product.price)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Original Price',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.originalPrice!.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${(((product.originalPrice! - product.price) / product.originalPrice!) * 100).toStringAsFixed(0)}% OFF',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildDetailRow('Brand', product.brand),
          _buildDivider(),
          _buildDetailRow('Category', product.category),
          _buildDivider(),
          _buildDetailRow('Model', product.model),
          _buildDivider(),
          _buildDetailRow('Color', product.color),
          _buildDivider(),
          _buildDetailRow('Condition', product.condition),
        ],
      ),
    );
  }

  Widget _buildSpecificationsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Specifications',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildDetailRow('Storage', product.storage),
          _buildDivider(),
          _buildDetailRow('RAM', product.ram),
          _buildDivider(),
          _buildDetailRow('Processor', product.processor),
          _buildDivider(),
          _buildDetailRow('Battery', product.battery),
          _buildDivider(),
          _buildDetailRow('OS Version', product.osVersion),
          _buildDivider(),
          _buildDetailRow('Warranty', product.warranty),
        ],
      ),
    );
  }

  Widget _buildInventorySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Inventory Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildDetailRow('Quantity in Stock', product.quantity.toString()),
          _buildDivider(),
          _buildDetailRow('Sold Count', product.soldCount.toString()),
          _buildDivider(),
          _buildDetailRow('Added Date', _formatDate(product.createdAt)),
          _buildDivider(),
          _buildDetailRow('Last Updated', _formatDate(product.updatedAt)),
          _buildDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Status',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: product.isActive
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  product.isActive ? 'Active' : 'Inactive',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: product.isActive
                        ? Colors.green.shade700
                        : Colors.red.shade700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    if (product.description.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            product.description,
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _shareProduct(context),
            icon: const Icon(Icons.share),
            label: const Text('Share'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _editProduct(context),
            icon: const Icon(Icons.edit),
            label: const Text('Edit'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(height: 1),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _editProduct(BuildContext context) {
    // Navigate to edit product screen
    // context.push('/edit-product', extra: product);
  }

  void _deleteProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "${product.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Delete product logic
              Navigator.pop(context);
              Navigator.pop(context); // Return to previous screen
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _shareProduct(BuildContext context) {
    // Share product details
    // Share.share('Check out ${product.name} - \$${product.price}');
  }
}

// Product Model
class Product {
  final String id;
  final String name;
  final String sku;
  final double price;
  final double? originalPrice;
  final String brand;
  final String category;
  final String model;
  final String color;
  final String condition;
  final String storage;
  final String ram;
  final String processor;
  final String battery;
  final String osVersion;
  final String warranty;
  final int quantity;
  final int soldCount;
  final String description;
  final bool isAvailable;
  final bool isActive;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.price,
    this.originalPrice,
    required this.brand,
    required this.category,
    required this.model,
    required this.color,
    required this.condition,
    required this.storage,
    required this.ram,
    required this.processor,
    required this.battery,
    required this.osVersion,
    required this.warranty,
    required this.quantity,
    required this.soldCount,
    required this.description,
    required this.isAvailable,
    required this.isActive,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });
}

