import 'package:flutter/material.dart';
import 'package:optom/domain/products/prosuct_model.dart';

class FormSectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const FormSectionTitle({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black87),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? hint;
  final TextInputType keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
    );
  }
}

class CustomPopupMenu<T> extends StatelessWidget {
  final String label;
  final IconData icon;
  final T? selectedValue;
  final String? displayValue;
  final String hint;
  final List<T> items;
  final IconData Function(T) getItemIcon;
  final Color Function(T) getItemColor;
  final String Function(T) getItemName;
  final void Function(T) onSelected;
  final bool isValid;

  const CustomPopupMenu({
    super.key,
    required this.label,
    required this.icon,
    this.selectedValue,
    this.displayValue,
    required this.hint,
    required this.items,
    required this.getItemIcon,
    required this.getItemColor,
    required this.getItemName,
    required this.onSelected,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      onSelected: onSelected,
      offset: const Offset(0, 45),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: !isValid ? Colors.red : Colors.grey.shade300,
            width: !isValid ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
            border: InputBorder.none,
            errorText: !isValid ? 'This field is required' : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  displayValue ?? hint,
                  style: TextStyle(
                    color: displayValue == null ? Colors.grey : Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
      ),
      itemBuilder: (context) => items.map((item) {
        return PopupMenuItem<T>(
          value: item,
          child: Row(
            children: [
              Icon(getItemIcon(item), color: getItemColor(item), size: 20),
              const SizedBox(width: 12),
              Text(getItemName(item)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final IconData icon;
  final T? value;
  final List<T> items;
  final String Function(T) displayName;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.icon,
    this.value,
    required this.items,
    required this.displayName,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem(value: item, child: Text(displayName(item)));
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  const SubmitButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class ProductValidators {
  static String? validateModel(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Model is required';
    }
    if (value.length < 2) {
      return 'Model must be at least 2 characters';
    }
    return null;
  }

  static String? validateRegion(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Region is required';
    }
    return null;
  }

  static String? validateStorage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Storage is required';
    }
    return null;
  }

  static String? validateColor(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Color is required';
    }
    return null;
  }

  static String? validateCost(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Cost is required';
    }
    final cost = double.tryParse(value);
    if (cost == null) {
      return 'Enter a valid number';
    }
    if (cost <= 0) {
      return 'Cost must be greater than 0';
    }
    return null;
  }

  static String? validateAvailableCount(String? value, bool isRequired) {
    if (!isRequired) return null;
    if (value == null || value.trim().isEmpty) {
      return 'Available count is required';
    }
    final count = int.tryParse(value);
    if (count == null || count <= 0) {
      return 'Enter a valid positive number';
    }
    return null;
  }
}

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  // Form Key
  final  GlobalKey<FormState> _formKey = GlobalKey();

  // Controllers
  late final List<TextEditingController> _controllers;
  late final TextEditingController _modelController;
  late final TextEditingController _regionController;
  late final TextEditingController _storageController;
  late final TextEditingController _colorController;
  late final TextEditingController _costController;
  late final TextEditingController _availableCountController;
  late final TextEditingController _imeiController;
  late final TextEditingController _barcodeController;
  late final TextEditingController _notesController;

  // Selected Values
  Condition? _condition;
  Status? _status;
  SellingStatus? _sellingStatus;
  SimSlotType? _simSlotType;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _modelController = TextEditingController();
    _regionController = TextEditingController();
    _storageController = TextEditingController();
    _colorController = TextEditingController();
    _costController = TextEditingController();
    _availableCountController = TextEditingController();
    _imeiController = TextEditingController();
    _barcodeController = TextEditingController();
    _notesController = TextEditingController();

    _controllers = [
      _modelController,
      _regionController,
      _storageController,
      _colorController,
      _costController,
      _availableCountController,
      _imeiController,
      _barcodeController,
      _notesController,
    ];
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool _isAvailableCountRequired() {
    return _sellingStatus == SellingStatus.available;
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;
    if (!_validateSelections()) return;

    final product = _createProduct();
    _onProductCreated(product);
  }

  bool _validateSelections() {
    if (_condition == null) return false;
    if (_status == null) return false;
    if (_sellingStatus == null) return false;
    if (_simSlotType == null) return false;
    return true;
  }

  Product _createProduct() {
    return Product(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      model: _modelController.text.trim(),
      region: _regionController.text.trim(),
      storage: _storageController.text.trim(),
      color: _colorController.text.trim(),
      cost: double.parse(_costController.text),
      condition: _condition!,
      status: _status!,
      notes: _notesController.text.trim(),
      sellingStatus: _sellingStatus!,
      availableCount: _isAvailableCountRequired()
          ? _availableCountController.text.trim()
          : null,
      imei: _imeiController.text.trim().isEmpty
          ? null
          : _imeiController.text.trim(),
      barcode: _barcodeController.text.trim().isEmpty
          ? null
          : _barcodeController.text.trim(),
      simSlotType: _simSlotType!,
    );
  }

  void _onProductCreated(Product product) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✓ Product created successfully'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.pop(context, product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildForm());
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Create New Product'),
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        TextButton.icon(
          onPressed: _handleSubmit,
          icon: const Icon(Icons.check_circle, size: 20),
          label: const Text('Save', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBasicInfoSection(),
            const SizedBox(height: 28),
            _buildStatusSection(),
            const SizedBox(height: 28),
            _buildSimSection(),
            const SizedBox(height: 28),
            _buildAdditionalInfoSection(),
            const SizedBox(height: 32),
            SubmitButton(
              onPressed: _handleSubmit,
              label: 'Create Product',
              icon: Icons.add_circle_outline,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormSectionTitle(
          title: 'Basic Information',
          icon: Icons.info_outline,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: _modelController,
          label: 'Model',
          icon: Icons.smartphone,
          hint: 'iPhone 14 Pro',
          validator: ProductValidators.validateModel,
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _regionController,
          label: 'Region',
          icon: Icons.public,
          hint: 'USA, Europe, etc.',
          validator: ProductValidators.validateRegion,
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _storageController,
          label: 'Storage',
          icon: Icons.storage,
          hint: '128GB, 256GB',
          validator: ProductValidators.validateStorage,
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _colorController,
          label: 'Color',
          icon: Icons.color_lens,
          hint: 'Space Black, Silver',
          validator: ProductValidators.validateColor,
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _costController,
          label: 'Cost',
          icon: Icons.attach_money,
          hint: '0.00',
          keyboardType: TextInputType.number,
          validator: ProductValidators.validateCost,
        ),
      ],
    );
  }

  Widget _buildStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormSectionTitle(title: 'Status & Condition', icon: Icons.tune),
        const SizedBox(height: 16),
        CustomPopupMenu<Condition>(
          label: 'Condition',
          icon: Icons.fiber_new,
          selectedValue: _condition,
          displayValue: _condition?.displayName,
          hint: 'Select condition',
          items: Condition.values,
          getItemIcon: (c) =>
              c == Condition.NEW ? Icons.fiber_new : Icons.autorenew,
          getItemColor: (c) =>
              c == Condition.NEW ? Colors.green : Colors.orange,
          getItemName: (c) => c.displayName,
          onSelected: (value) => setState(() => _condition = value),
          isValid: _condition != null,
        ),
        const SizedBox(height: 12),
        CustomPopupMenu<Status>(
          label: 'Status',
          icon: Icons.build,
          selectedValue: _status,
          displayValue: _status?.displayName,
          hint: 'Select status',
          items: Status.values,
          getItemIcon: (s) =>
              s == Status.working ? Icons.check_circle : Icons.error,
          getItemColor: (s) => s == Status.working ? Colors.green : Colors.red,
          getItemName: (s) => s.displayName,
          onSelected: (value) => setState(() => _status = value),
          isValid: _status != null,
        ),
        const SizedBox(height: 12),
        CustomDropdown<SellingStatus>(
          label: 'Selling Status',
          icon: Icons.shopping_cart,
          value: _sellingStatus,
          items: SellingStatus.values,
          displayName: (s) => s.displayName,
          onChanged: (value) => setState(() => _sellingStatus = value),
          validator: (value) => value == null ? 'Required' : null,
        ),
        if (_isAvailableCountRequired()) ...[
          const SizedBox(height: 12),
          CustomTextField(
            controller: _availableCountController,
            label: 'Available Count',
            icon: Icons.numbers,
            hint: 'Number of units',
            keyboardType: TextInputType.number,
            validator: (value) => ProductValidators.validateAvailableCount(
              value,
              _isAvailableCountRequired(),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSimSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormSectionTitle(
          title: 'SIM Configuration',
          icon: Icons.sim_card,
        ),
        const SizedBox(height: 16),
        CustomPopupMenu<SimSlotType>(
          label: 'SIM Slot Type',
          icon: Icons.sim_card,
          selectedValue: _simSlotType,
          displayValue: _simSlotType?.displayName,
          hint: 'Select SIM type',
          items: SimSlotType.values,
          getItemIcon: (s) =>
              s == SimSlotType.wifi ? Icons.wifi : Icons.sim_card,
          getItemColor: (s) => Colors.blue,
          getItemName: (s) => s.displayName,
          onSelected: (value) => setState(() => _simSlotType = value),
          isValid: _simSlotType != null,
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormSectionTitle(
          title: 'Additional Information',
          icon: Icons.more_horiz,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: _imeiController,
          label: 'IMEI',
          icon: Icons.qr_code_scanner,
          hint: 'Optional',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _barcodeController,
          label: 'Barcode',
          icon: Icons.barcode_reader,
          hint: 'Optional',
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _notesController,
          label: 'Notes',
          icon: Icons.note,
          hint: 'Additional notes...',
          maxLines: 3,
        ),
      ],
    );
  }
}
