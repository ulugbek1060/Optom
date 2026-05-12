import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optom/domain/products/prosuct_model.dart';
import 'package:optom/router/app_router.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.menu,
                      color: Colors.black87,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Каталог',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    icon: Icon(Icons.add_rounded),
                    onPressed: () => context.go(AppRouter.createProduct),
                    label: Text('Create product'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            _buildSearchField(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: demoProducts.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) =>
                    ProductCard(product: demoProducts[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.black87 : Colors.grey[500],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Поиск продуктов',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
          prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _formatProductTitle(product),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                if (product.condition == Condition.used)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'B/U',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: Colors.amber,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${product.cost.toStringAsFixed(0)} USD',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    product.availableCount ?? '0 шт',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    product.imei ??
                        '${product.id.substring(0, 3).toUpperCase()}-${product.id.substring(0, 5)}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[500],
                      fontFamily: 'monospace',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                _buildInfoChip(Icons.sim_card, product.simSlotType.shortName),
                _buildInfoChip(Icons.public, product.region),
                _buildInfoChip(Icons.storage, product.storage),
                if (product.status == Status.defective)
                  _buildInfoChip(
                    Icons.warning_amber_rounded,
                    'Defective',
                    color: Colors.red,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    IconData icon,
    String label, {
    Color color = Colors.grey,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatProductTitle(Product product) {
    final colorName = product.color.toUpperCase();
    final modelName = product.model.toUpperCase();
    return '$modelName $colorName ${product.storage}';
  }
}

// ==================== DEMO DATA ====================
final List<Product> demoProducts = [
  Product(
    id: 'EMN-35588',
    model: 'IPHONE 17 PRO',
    region: 'Global',
    storage: '256GB',
    color: 'SILVER',
    cost: 1200,
    condition: Condition.used,
    status: Status.working,
    notes: '',
    sellingStatus: SellingStatus.available,
    availableCount: '0 шт',
    imei: '356584868826234',
    barcode: null,
    simSlotType: SimSlotType.simPlusEsim,
  ),
  Product(
    id: 'QFU-93802',
    model: 'IPHONE 16 PRO MAX',
    region: 'Global',
    storage: '256GB',
    color: 'DESERT TITANIUM',
    cost: 1320,
    condition: Condition.NEW,
    status: Status.working,
    notes: '',
    sellingStatus: SellingStatus.available,
    availableCount: '0 шт',
    imei: '357002338899565',
    barcode: null,
    simSlotType: SimSlotType.simPlusEsim,
  ),
  Product(
    id: 'PKD-16155',
    model: 'IPHONE 15 PRO',
    region: 'Global',
    storage: '256GB',
    color: 'TITANIUM',
    cost: 700,
    condition: Condition.used,
    status: Status.working,
    notes: '',
    sellingStatus: SellingStatus.available,
    availableCount: '0 шт',
    imei: '355361720874012',
    barcode: null,
    simSlotType: SimSlotType.simPlusEsim,
  ),
  Product(
    id: '1',
    model: 'IPHONE 13 PRO MAX',
    region: 'Global',
    storage: '128GB',
    color: 'GRAPHITE',
    cost: 550,
    condition: Condition.used,
    status: Status.working,
    notes: 'Battery 89%',
    sellingStatus: SellingStatus.available,
    availableCount: '1 шт',
    imei: '123456789012345',
    barcode: null,
    simSlotType: SimSlotType.dualSim,
  ),
  Product(
    id: 'AIR-001',
    model: 'AIR PODS 2 PRO',
    region: 'Global',
    storage: 'N/A',
    color: 'WHITE',
    cost: 199,
    condition: Condition.NEW,
    status: Status.working,
    notes: '',
    sellingStatus: SellingStatus.available,
    availableCount: '5 шт',
    imei: null,
    barcode: null,
    simSlotType: SimSlotType.wifi,
  ),
];
