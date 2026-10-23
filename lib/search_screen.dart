
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // ============ CORES ============

  final Color vermelho = const Color(0xFFE53935);
  final Color vermelhoEscuro = const Color(0xFFC62828);
  final Color fundo = const Color(0xFFF8F8FA);
  final Color texto = const Color(0xFF292929);
  final Color cinza = const Color(0xFF777777);

  // ============ VARIAVEIS ============

  final TextEditingController pesquisaController =
      TextEditingController();

  int filtroSelecionado = 0;
  int paginaSelecionada = 1;

  final List<String> filtros = [
    'Todos',
    'Próximos',
    'Entrega rápida',
    'Melhor avaliação',
  ];

  final List<Map<String, dynamic>> produtos = [
    {
      'restaurante': 'Burger House',
      'nome': 'Smash Burger Especial',
      'avaliacao': 4.9,
      'tempo': 25,
      'distancia': 1.2,
      'preco': 'R\$ 29,90',
      'imagem':
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
    },
    {
      'restaurante': 'Bella Pizza',
      'nome': 'Pizza de Calabresa',
      'avaliacao': 4.8,
      'tempo': 35,
      'distancia': 2.8,
      'preco': 'R\$ 42,90',
      'imagem':
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
    },
    {
      'restaurante': 'Tropical Fresh',
      'nome': 'Açaí com frutas',
      'avaliacao': 4.9,
      'tempo': 20,
      'distancia': 0.8,
      'preco': 'R\$ 19,90',
      'imagem':
          'https://images.unsplash.com/photo-1490474418585-ba9bad8fd0ea?w=400',
    },
    {
      'restaurante': 'Sushi Express',
      'nome': 'Combo de Sushi',
      'avaliacao': 4.7,
      'tempo': 30,
      'distancia': 3.5,
      'preco': 'R\$ 39,90',
      'imagem':
          'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=400',
    },
  ];

  // ============ PESQUISA E FILTROS ============

  List<Map<String, dynamic>> get produtosFiltrados {
    final busca = pesquisaController.text.trim().toLowerCase();

    List<Map<String, dynamic>> resultado = produtos.where((produto) {
      final nome = (produto['nome'] as String).toLowerCase();
      final restaurante =
          (produto['restaurante'] as String).toLowerCase();

      return nome.contains(busca) ||
          restaurante.contains(busca);
    }).toList();

    switch (filtroSelecionado) {
      case 1:
        resultado.sort(
          (a, b) => (a['distancia'] as double)
              .compareTo(b['distancia'] as double),
        );
        break;

      case 2:
        resultado = resultado
            .where((p) => (p['tempo'] as int) <= 25)
            .toList();
        break;

      case 3:
        resultado.sort(
          (a, b) => (b['avaliacao'] as double)
              .compareTo(a['avaliacao'] as double),
        );
        break;
    }

    return resultado;
  }

  @override
  void dispose() {
    pesquisaController.dispose();
    super.dispose();
  }

  // ============ TELA PRINCIPAL ============

  @override
  Widget build(BuildContext context) {
    final lista = produtosFiltrados;

    return Scaffold(
      backgroundColor: fundo,

      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cabecalho(),

            _campoPesquisa(),

            _secaoFiltros(),

            _tituloResultados(lista.length),

            Expanded(
              child: lista.isEmpty
                  ? _resultadoVazio()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        16, 0, 16, 16,
                      ),
                      itemCount: lista.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        return _cartaoProduto(lista[index]);
                      },
                    ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: _navegacaoInferior(),
    );
  }

  // ============ CABECALHO ============

  Widget _cabecalho() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EXPLORAR',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              color: Color(0xFF888888),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            'Buscar',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w800,
              color: texto,
            ),
          ),
        ],
      ),
    );
  }

  // ============ CAMPO DE PESQUISA ============

  Widget _campoPesquisa() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Container(
        height: 47,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE4E4E4),
          ),
        ),
        child: TextField(
          controller: pesquisaController,
          onChanged: (_) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Produto, categoria ou restaurante',
            hintStyle: const TextStyle(
              fontSize: 11,
              color: Color(0xFFAAAAAA),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: vermelho,
              size: 21,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 42,
            ),
            suffixIcon: pesquisaController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      pesquisaController.clear();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 18,
                    ),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
            ),
          ),
        ),
      ),
    );
  }

  // ============ FILTROS ============

  Widget _secaoFiltros() {
    return Padding(
      padding: const EdgeInsets.only(top: 19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              'Filtros',
              style: TextStyle(
                color: texto,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 9),

          SizedBox(
            height: 32,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: filtros.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 6),
              itemBuilder: (context, index) {
                final selecionado =
                    filtroSelecionado == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      filtroSelecionado = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selecionado
                          ? vermelho
                          : Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: selecionado
                            ? vermelho
                            : const Color(0xFFE0E0E0),
                      ),
                    ),
                    child: Text(
                      filtros[index],
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: selecionado
                            ? Colors.white
                            : cinza,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============ TITULO DOS RESULTADOS ============

  Widget _tituloResultados(int quantidade) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Resultados',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: texto,
              ),
            ),
          ),

          Text(
            '$quantidade ${quantidade == 1 ? 'item' : 'itens'}',
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }

  // ============ CARTAO DO PRODUTO ============

  Widget _cartaoProduto(Map<String, dynamic> produto) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color(0xFFE3E3E3),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.network(
              produto['imagem'] as String,
              width: 84,
              height: 84,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 84,
                  height: 84,
                  color: const Color(0xFFFFEEEE),
                  child: Icon(
                    Icons.restaurant,
                    size: 30,
                    color: vermelho,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produto['restaurante'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Color(0xFF888888),
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      produto['nome'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: texto,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 12,
                          color: Color(0xFFFFB300),
                        ),

                        const SizedBox(width: 2),

                        Text(
                          '${produto['avaliacao']}',
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(width: 5),

                        const Text(
                          '•',
                          style: TextStyle(
                            color: Color(0xFFAAAAAA),
                            fontSize: 9,
                          ),
                        ),

                        const SizedBox(width: 4),

                        Flexible(
                          child: Text(
                            '${produto['tempo']} min entrega',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xFF888888),
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
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: vermelhoEscuro,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 25,
                      child: OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${produto['nome']} selecionado!',
                                ),
                                duration:
                                    const Duration(seconds: 2),
                              ),
                            );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: vermelhoEscuro,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          side: BorderSide(
                            color: vermelho,
                            width: 0.8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Adicionar',
                          style: TextStyle(fontSize: 9),
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
  }

  // ============ NENHUM RESULTADO ============

  Widget _resultadoVazio() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              color: vermelho.withOpacity(0.7),
              size: 52,
            ),

            const SizedBox(height: 12),

            Text(
              'Nenhum resultado encontrado',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: texto,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Tente outro termo ou selecione um filtro diferente.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF888888),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============ NAVEGACAO INFERIOR ============

  Widget _navegacaoInferior() {
    final itens = [
      {
        'icone': Icons.grid_view_rounded,
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
            color: Color(0xFFE8E8E8),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 55,
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
                    child: Center(
                      child: AnimatedContainer(
                        duration:
                            const Duration(milliseconds: 180),
                        width: 57,
                        height: 39,
                        decoration: BoxDecoration(
                          color: selecionado
                              ? vermelho.withOpacity(0.10)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          itens[index]['icone'] as IconData,
                          color: selecionado
                              ? vermelho
                              : const Color(0xFF999999),
                          size: 23,
                        ),
                      ),
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
