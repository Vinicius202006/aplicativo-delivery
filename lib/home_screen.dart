
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //============ VARIAVEIS E FUNCOES ===========

  final Color vermelho = const Color(0xFFE53935);
  final Color vermelhoEscuro = const Color(0xFFC62828);
  final Color fundo = const Color(0xFFF8F8FA);
  final Color texto = const Color(0xFF292929);
  final Color cinza = const Color(0xFF777777);

  int categoriaSelecionada = 0;
  int paginaSelecionada = 0;

  final TextEditingController pesquisaController =
      TextEditingController();

  final List<Map<String, dynamic>> categorias = [
    {'nome': 'Hambúrguer', 'icone': Icons.lunch_dining},
    {'nome': 'Pizza', 'icone': Icons.local_pizza},
    {'nome': 'Japonesa', 'icone': Icons.set_meal},
    {'nome': 'Bebidas', 'icone': Icons.local_cafe},
    {'nome': 'Sobremesas', 'icone': Icons.icecream},
  ];

  final List<Map<String, dynamic>> produtos = [
    {
      'restaurante': 'Snack House',
      'nome': 'Smash Burger Especial',
      'avaliacao': '5.0',
      'tempo': '25-35 min',
      'preco': 'R\$ 29,90',
      'imagem':
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
    },
    {
      'restaurante': 'Nono Michelle',
      'nome': 'Pizza de Calabresa',
      'avaliacao': '4.8',
      'tempo': '30-40 min',
      'preco': 'R\$ 42,90',
      'imagem':
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
    },
    {
      'restaurante': 'Açaí da barra',
      'nome': 'Açaí com frutas',
      'avaliacao': '4.9',
      'tempo': '15-25 min',
      'preco': 'R\$ 19,90',
      'imagem':
          'https://images.unsplash.com/photo-1490474418585-ba9bad8fd0ea?w=400',
    },
  ];

  @override
  void dispose() {
    pesquisaController.dispose();
    super.dispose();
  }

  //==================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,

      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cabecalho(),
              _apresentacao(),
              _pesquisa(),
              _promocao(),

              _tituloSecao(
                'Categorias',
                'Ver todas',
                () {},
              ),

              _categoriasWidget(),

              _tituloSecao(
                'Mais pedidos',
                'Ver todos',
                () {},
              ),

              _listaProdutos(),
            ],
          ),
        ),
      ),

      bottomNavigationBar: _navegacaoInferior(),
    );
  }

  //============ CABECALHO ============

  Widget _cabecalho() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 8),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: vermelho.withOpacity(0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              Icons.location_on_outlined,
              color: vermelho,
              size: 24,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ENTREGAR EM',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF777777),
                    letterSpacing: 0.8,
                  ),
                ),

                const SizedBox(height: 3),

                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Casa',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: texto,
                        ),
                      ),
                    ),

                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 18,
                      color: vermelho,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: const Color(0xFFEEEEEE),
              ),
            ),
            child: IconButton(
              onPressed: () {},
              tooltip: 'Carrinho',
              icon: Icon(
                Icons.shopping_bag_outlined,
                color: vermelho,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //============ APRESENTACAO ============

  Widget _apresentacao() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Olá, tudo bem? 👋',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF777777),
            ),
          ),

          const SizedBox(height: 7),

          Text(
            'O que vamos pedir\nhoje?',
            style: TextStyle(
              fontSize: 27,
              height: 1.12,
              fontWeight: FontWeight.w800,
              color: texto,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Seu prato favorito está a poucos cliques.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF777777),
            ),
          ),
        ],
      ),
    );
  }

  //============ PESQUISA ============

  Widget _pesquisa() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 49,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color(0xFFE8E8E8),
          ),
        ),
        child: TextField(
          controller: pesquisaController,
          decoration: const InputDecoration(
            hintText: 'Buscar pratos ou restaurantes',
            hintStyle: TextStyle(
              fontSize: 12,
              color: Color(0xFF777777),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Color(0xFFE53935),
              size: 22,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              vertical: 14,
            ),
          ),
        ),
      ),
    );
  }

  //============ PROMOCAO ============

  Widget _promocao() {
    return Container(
      height: 156,
      margin: const EdgeInsets.fromLTRB(20, 19, 20, 25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [vermelho, vermelhoEscuro],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: vermelho.withOpacity(0.16),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -25,
            top: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(
              16, 17, 16, 15,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.20),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'OFERTA ESPECIAL',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'Seu combo\nfavorito!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          height: 1.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        'Até 30% OFF no pedido',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                      const SizedBox(height: 7),

                      SizedBox(
                        height: 28,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color(0xFFC62828),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Aproveitar',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500',
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 120,
                          color: Colors.white.withOpacity(0.15),
                          child: const Icon(
                            Icons.lunch_dining,
                            color: Colors.white,
                            size: 60,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //============ TITULO DAS SECOES ============

  Widget _tituloSecao(
    String titulo,
    String acao,
    VoidCallback aoClicar,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              titulo,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: texto,
              ),
            ),
          ),

          GestureDetector(
            onTap: aoClicar,
            child: Text(
              acao,
              style: TextStyle(
                color: vermelho,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //============ CATEGORIAS ============

  Widget _categoriasWidget() {
    return SizedBox(
      height: 111,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: 17),
        itemBuilder: (context, index) {
          final categoria = categorias[index];
          final selecionada =
              categoriaSelecionada == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                categoriaSelecionada = index;
              });
            },
            child: SizedBox(
              width: 66,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      color: selecionada
                          ? vermelho
                          : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: selecionada
                            ? vermelho
                            : const Color(0xFFEEEEEE),
                      ),
                    ),
                    child: Icon(
                      categoria['icone'] as IconData,
                      color: selecionada
                          ? Colors.white
                          : vermelho,
                      size: 29,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    categoria['nome'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: selecionada
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: selecionada ? vermelho : texto,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //============ LISTA DE PRODUTOS ============

  Widget _listaProdutos() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: produtos.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: 11),
      itemBuilder: (context, index) {
        final produto = produtos[index];

        return Container(
          height: 120,
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: const Color(0xFFEAEAEA),
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  produto['imagem'] as String,
                  width: 98,
                  height: 102,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 98,
                      height: 102,
                      color: const Color(0xFFFFEEEE),
                      child: Icon(
                        Icons.restaurant,
                        color: vermelho,
                        size: 35,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 11),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          produto['restaurante'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 10,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          produto['nome'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: texto,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFFFB300),
                              size: 15,
                            ),

                            const SizedBox(width: 3),

                            Text(
                              produto['avaliacao'] as String,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(width: 7),

                            const Icon(
                              Icons.access_time,
                              color: Color(0xFF777777),
                              size: 12,
                            ),

                            const SizedBox(width: 3),

                            Flexible(
                              child: Text(
                                produto['tempo'] as String,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFF777777),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            produto['preco'] as String,
                            style: TextStyle(
                              color: vermelhoEscuro,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${produto['nome']} selecionado!',
                                  ),
                                  duration:
                                      const Duration(seconds: 2),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: vermelho,
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 11,
                              ),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(9),
                              ),
                            ),
                            child: const Text(
                              'Adicionar +',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //============ NAVEGACAO INFERIOR ============

  Widget _navegacaoInferior() {
    final itens = [
      {
        'icone': Icons.home_rounded,
        'titulo': 'Início',
      },
      {
        'icone': Icons.search_rounded,
        'titulo': 'Buscar',
      },
      {
        'icone': Icons.receipt_long_outlined,
        'titulo': 'Pedidos',
      },
      {
        'icone': Icons.person_outline_rounded,
        'titulo': 'Perfil',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(
            color: Color(0xFFEEEEEE),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 65,
          child: Row(
            children: List.generate(
              itens.length,
              (index) {
                final selecionado =
                    paginaSelecionada == index;

                return Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        paginaSelecionada = index;
                      });
                    },
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration:
                              const Duration(milliseconds: 180),
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: selecionado
                                ? vermelho.withOpacity(0.10)
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                          child: Icon(
                            itens[index]['icone'] as IconData,
                            size: 23,
                            color: selecionado
                                ? vermelho
                                : cinza,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          itens[index]['titulo'] as String,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: selecionado
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: selecionado
                                ? vermelho
                                : cinza,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
