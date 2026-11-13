
import 'package:flutter/material.dart';

class PedidosScreen extends StatefulWidget {
  const PedidosScreen({super.key});

  @override
  State<PedidosScreen> createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<PedidosScreen> {
  int abaSelecionada = 0;
  int itemSelecionado = 2;

  final Color vermelho = const Color(0xFFE53935);
  final Color vermelhoEscuro = const Color(0xFFC62828);
  final Color fundo = const Color(0xFFF8F8FA);
  final Color texto = const Color(0xFF292929);
  final Color cinza = const Color(0xFF777777);

  final List<Map<String, dynamic>> pedidosEmAndamento = [
  {
    'numero': '#0001',
    'restaurante': 'Mata Fome',
    'status': 'Em preparo',
    'previsao': '00:45',
    'valor': '35,00',
    'produtos': [
      {
        'nome': 'Hambúrguer',
        'imagem': 'assets/hamburguer.jpg',
      },
      {
        'nome': 'Pizza',
        'imagem': 'assets/pizza.jpg',
      },
    ],
  },
  {
    'numero': '#0002',
    'restaurante': 'Snack House',
    'status': 'Em preparo',
    'previsao': '00:30',
    'valor': '49,90',
    'produtos': [
      {
        'nome': 'Sorvete',
        'imagem': 'assets/sorvete.jpg',
      },
      {
        'nome': 'Hambúrguer',
        'imagem': 'assets/hamburguer.jpg',
      },
    ],
  },
];

final List<Map<String, dynamic>> pedidosAnteriores = [
  {
    'numero': '#0003',
    'restaurante': 'Pizzaria Valett',
    'status': 'Entregue',
    'previsao': 'Finalizado',
    'valor': '100,00',
    'produtos': [
      {
        'nome': 'Pizza',
        'imagem': 'assets/pizza.jpg',
      },
      {
        'nome': 'Sorvete',
        'imagem': 'assets/sorvete.jpg',
      },
    ],
  },
];

  @override
  Widget build(BuildContext context) {
    final pedidos = abaSelecionada == 0
        ? pedidosEmAndamento
        : pedidosAnteriores;

    return Scaffold(
      backgroundColor: fundo,

      body: SafeArea(
        child: Column(
          children: [
            // CABEÇALHO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(22, 28, 22, 22),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ACOMPANHAMENTO',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.3,
                      color: vermelho,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Meus pedidos',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: texto,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'Acompanhe seus pedidos por aqui.',
                    style: TextStyle(
                      fontSize: 13,
                      color: cinza,
                    ),
                  ),
                ],
              ),
            ),

            // CONTEÚDO
            Expanded(
              child: Column(
                children: [
                  // SELETOR DE ABAS
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 18),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDEDF0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        _botaoAba('Em andamento', 0),
                        _botaoAba('Anteriores', 1),
                      ],
                    ),
                  ),

                  // LISTA DE PEDIDOS
                  Expanded(
                    child: pedidos.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.receipt_long_outlined,
                                  size: 55,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Nenhum pedido encontrado.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: cinza,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(
                              20, 0, 20, 20,
                            ),
                            itemCount: pedidos.length,
                            itemBuilder: (context, index) {
                              return _cartaoPedido(pedidos[index]);
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // NAVEGAÇÃO INFERIOR
      bottomNavigationBar: _barraNavegacao(),
    );
  }

  // BOTÕES DAS ABAS
  Widget _botaoAba(String titulo, int indice) {
    final selecionado = abaSelecionada == indice;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            abaSelecionada = indice;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selecionado ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: selecionado
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Text(
            titulo,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight:
                  selecionado ? FontWeight.bold : FontWeight.normal,
              color: selecionado ? vermelho : cinza,
            ),
          ),
        ),
      ),
    );
  }

  // CARTÃO DO PEDIDO
  Widget _cartaoPedido(Map<String, dynamic> pedido) {
    final entregue = abaSelecionada == 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEAEAEA),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // NÚMERO E STATUS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PEDIDO ${pedido['numero']}',
                style: TextStyle(
                  fontSize: 10,
                  color: cinza,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: entregue
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFFFF0EE),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  pedido['status'],
                  style: TextStyle(
                    fontSize: 10,
                    color: entregue
                        ? Colors.green.shade700
                        : vermelhoEscuro,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // RESTAURANTE
          Text(
            pedido['restaurante'],
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: texto,
            ),
          ),

          const SizedBox(height: 13),

          const Divider(height: 1),

          const SizedBox(height: 12),

          // PRODUTOS
          // PRODUTOS
Column(
  children: List.generate(
    (pedido['produtos'] as List).length,
    (index) {
      final produto = pedido['produtos'][index];

      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                produto['imagem'],
                width: 55,
                height: 55,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                '1x ${produto['nome']}',
                style: TextStyle(
                  fontSize: 12,
                  color: cinza,
                ),
              ),
            ),
          ],
        ),
      );
    },
  ),
),

          const SizedBox(height: 12),

          const Divider(height: 1),

          const SizedBox(height: 12),

          // PREVISÃO E VALOR
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 15,
                    color: cinza,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    entregue
                        ? 'Pedido finalizado'
                        : 'Previsão: ${pedido['previsao']}',
                    style: TextStyle(
                      fontSize: 11,
                      color: cinza,
                    ),
                  ),
                ],
              ),

              Text(
                'R\$ ${pedido['valor']}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: texto,
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          // BOTÃO ACOMPANHAR
          if (!entregue)
            SizedBox(
              width: double.infinity,
              height: 43,
              child: ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: vermelho,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                child: const Text(
                  'Acompanhar pedido',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // BARRA DE NAVEGAÇÃO INFERIOR
  Widget _barraNavegacao() {
    final icones = [
      Icons.grid_view_rounded,
      Icons.search_rounded,
      Icons.receipt_long_outlined,
      Icons.person_outline_rounded,
    ];

    final nomes = [
      'Início',
      'Buscar',
      'Pedidos',
      'Perfil',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFEAEAEA)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          icones.length,
          (index) {
            final selecionado = itemSelecionado == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  itemSelecionado = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: selecionado
                      ? vermelho.withOpacity(0.10)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icones[index],
                  size: 23,
                  color: selecionado ? vermelho : cinza,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
