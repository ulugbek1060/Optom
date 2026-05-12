import 'package:flutter/material.dart';

class SellProductScreen extends StatefulWidget {
  const SellProductScreen({super.key});

  @override
  State<SellProductScreen> createState() => _SellProductScreenState();
}

class _SellProductScreenState extends State<SellProductScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _productNameController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _imeiController = TextEditingController();
  final _storageController = TextEditingController();
  final _ramController = TextEditingController();
  final _colorController = TextEditingController();
  final _clientNameController = TextEditingController();
  final _clientPhoneController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();
  final _notesController = TextEditingController();

  // Dropdown values
  String _condition = 'New';
  String _paymentMethod = 'Cash';
  bool _isPaid = false;
  DateTime? _saleDate;

  final List<String> _conditions = ['New', 'Like New', 'Good', 'Fair', 'Used'];
  final List<String> _paymentMethods = ['Cash', 'Credit Card', 'Bank Transfer', 'Installment'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Product'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Information Section
              _buildSectionHeader('Product Information', Icons.info),
              const SizedBox(height: 12),
              _buildProductInfoSection(),

              const SizedBox(height: 24),

              // Device Specifications Section
              _buildSectionHeader('Device Specifications', Icons.settings),
              const SizedBox(height: 12),
              _buildSpecificationsSection(),

              const SizedBox(height: 24),

              // Client Information Section
              _buildSectionHeader('Client Information', Icons.person),
              const SizedBox(height: 12),
              _buildClientSection(),

              const SizedBox(height: 24),

              // Payment Information Section
              _buildSectionHeader('Payment Information', Icons.payment),
              const SizedBox(height: 12),
              _buildPaymentSection(),

              const SizedBox(height: 24),

              // Additional Notes
              _buildNotesSection(),

              const SizedBox(height: 32),

              // Sell Button
              _buildSellButton(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: Colors.green.shade700),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: _productNameController,
            decoration: const InputDecoration(
              labelText: 'Product Name *',
              hintText: 'e.g., iPhone 14 Pro, Samsung Galaxy S23',
              prefixIcon: Icon(Icons.sell),
              border: OutlineInputBorder(),
            ),
            validator: (value) => value?.isEmpty ?? true ? 'Product name required' : null,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _brandController,
                  decoration: const InputDecoration(
                    labelText: 'Brand *',
                    hintText: 'Apple, Samsung, Google',
                    prefixIcon: Icon(Icons.branding_watermark),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? 'Brand required' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _modelController,
                  decoration: const InputDecoration(
                    labelText: 'Model *',
                    hintText: 'A2849, SM-S918B',
                    prefixIcon: Icon(Icons.devices),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? 'Model required' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _imeiController,
            decoration: const InputDecoration(
              labelText: 'IMEI Number *',
              hintText: '15-digit IMEI number',
              prefixIcon: Icon(Icons.qr_code),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'IMEI required';
              if (value!.length != 15) return 'IMEI must be 15 digits';
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSpecificationsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _storageController,
                  decoration: const InputDecoration(
                    labelText: 'Storage *',
                    hintText: '128GB, 256GB, 512GB',
                    prefixIcon: Icon(Icons.storage),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? 'Storage required' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _ramController,
                  decoration: const InputDecoration(
                    labelText: 'RAM',
                    hintText: '6GB, 8GB, 12GB',
                    prefixIcon: Icon(Icons.memory),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _colorController,
                  decoration: const InputDecoration(
                    labelText: 'Color *',
                    hintText: 'Black, White, Blue',
                    prefixIcon: Icon(Icons.color_lens),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? 'Color required' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _condition,
                  decoration: const InputDecoration(
                    labelText: 'Condition *',
                    prefixIcon: Icon(Icons.verified),
                    border: OutlineInputBorder(),
                  ),
                  items: _conditions.map((condition) {
                    return DropdownMenuItem(
                      value: condition,
                      child: Text(condition),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _condition = value!;
                    });
                  },
                  validator: (value) => value == null ? 'Condition required' : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClientSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: _clientNameController,
            decoration: const InputDecoration(
              labelText: 'Client Name *',
              hintText: 'Full name of client',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            validator: (value) => value?.isEmpty ?? true ? 'Client name required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _clientPhoneController,
            decoration: const InputDecoration(
              labelText: 'Phone Number *',
              hintText: 'Client contact number',
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Phone number required';
              if (value!.length < 10) return 'Invalid phone number';
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price *',
                    hintText: '0.00',
                    prefixIcon: Icon(Icons.attach_money),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Price required';
                    if (double.tryParse(value!) == null) return 'Invalid price';
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _discountController,
                  decoration: const InputDecoration(
                    labelText: 'Discount',
                    hintText: '0.00',
                    prefixIcon: Icon(Icons.local_offer),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _paymentMethod,
                  decoration: const InputDecoration(
                    labelText: 'Payment Method *',
                    prefixIcon: Icon(Icons.payment),
                    border: OutlineInputBorder(),
                  ),
                  items: _paymentMethods.map((method) {
                    return DropdownMenuItem(
                      value: method,
                      child: Text(method),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _paymentMethod = value!;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (date != null) {
                      setState(() {
                        _saleDate = date;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Sale Date *',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                    child: Text(
                      _saleDate != null
                          ? '${_saleDate!.day}/${_saleDate!.month}/${_saleDate!.year}'
                          : 'Select date',
                      style: TextStyle(
                        color: _saleDate != null ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _isPaid ? Colors.green.shade50 : Colors.orange.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _isPaid ? Colors.green.shade200 : Colors.orange.shade200,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Status',
                        style: TextStyle(
                          fontSize: 12,
                          color: _isPaid ? Colors.green : Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _isPaid ? 'PAID ✓' : 'WAITING PAYMENT ⏳',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _isPaid ? Colors.green : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _isPaid,
                  onChanged: (value) {
                    setState(() {
                      _isPaid = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),
          ),
          if (!_isPaid) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.blue.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This sale is marked as waiting payment. You can update status when payment is received.',
                      style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
                    ),
                  ),
                ],
              ),
            ),
          ],
          // Calculate total after discount
          if (_priceController.text.isNotEmpty)
            _buildPriceSummary(),
        ],
      ),
    );
  }

  Widget _buildPriceSummary() {
    double price = double.tryParse(_priceController.text) ?? 0;
    double discount = double.tryParse(_discountController.text) ?? 0;
    double total = price - discount;

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal:'),
              Text('\$${price.toStringAsFixed(2)}'),
            ],
          ),
          if (discount > 0) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Discount:'),
                Text('-\$${discount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.red)),
              ],
            ),
          ],
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Additional Notes', Icons.note),
        const SizedBox(height: 12),
        TextFormField(
          controller: _notesController,
          decoration: const InputDecoration(
            hintText: 'Add any additional notes about the product or sale...',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(16),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildSellButton() {
    double price = double.tryParse(_priceController.text) ?? 0;
    double discount = double.tryParse(_discountController.text) ?? 0;
    double total = price - discount;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _confirmSale(total);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
        child: Column(
          children: [
            Text(
              'SELL PRODUCT',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14),
            ),
            if (!_isPaid)
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  '⏳ Waiting Payment',
                  style: TextStyle(fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _confirmSale(double total) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Sale'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: ${_productNameController.text}'),
            const SizedBox(height: 8),
            Text('Client: ${_clientNameController.text}'),
            const SizedBox(height: 8),
            Text('Total Amount: \$${total.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text(
              'Status: ${_isPaid ? "PAID" : "WAITING PAYMENT"}',
              style: TextStyle(
                color: _isPaid ? Colors.green : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 24),
            const Text('Do you want to complete this sale?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Process sale here
              Navigator.pop(context);
              Navigator.pop(context);
              _showSuccessDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('Confirm Sale'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sale Completed!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('Product sold to ${_clientNameController.text}'),
            const SizedBox(height: 8),
            Text('Total: \$${_priceController.text}'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _imeiController.dispose();
    _storageController.dispose();
    _ramController.dispose();
    _colorController.dispose();
    _clientNameController.dispose();
    _clientPhoneController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}