import 'package:flutter/material.dart';
import 'package:netflix/filmler.dart';

class AnaSayfa extends StatefulWidget {
  
  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
  
  const AnaSayfa({Key? key}) : super(key: key);
}

class _AnaSayfaState extends State<AnaSayfa> {

  //BottomNavigatorBar seçilen ikon index
  int _currentIndex = 0;


  Future<List<Filmler>> populerFilmler() async{
    var filmlerListesi = <Filmler>[];

    var f1 = Filmler(filmId: 1, filmResimAdi: "witcher.png");
    var f2 = Filmler(filmId: 2, filmResimAdi: "narcos.png");
    var f3 = Filmler(filmId: 3, filmResimAdi: "black_af.jpg");
    var f4 = Filmler(filmId: 4, filmResimAdi: "LaCasa.png");


    filmlerListesi.add(f1);
    filmlerListesi.add(f2);
    filmlerListesi.add(f3);
    filmlerListesi.add(f4);


    return filmlerListesi;
  }
  Future<List<Filmler>> gundemdekiFilmler() async{
    var filmlerListesiG = <Filmler>[];
    var f1 = Filmler(filmId: 5, filmResimAdi: "tiger.png");
    var f2 = Filmler(filmId: 6, filmResimAdi: "education.png");
    var f3 = Filmler(filmId: 7, filmResimAdi: "underground.png");
    var f4 = Filmler(filmId: 8, filmResimAdi: "marriage.png");

    filmlerListesiG.add(f1);
    filmlerListesiG.add(f2);
    filmlerListesiG.add(f3);
    filmlerListesiG.add(f4);

    return filmlerListesiG;
  }


  Future<List<Filmler>> izlenilenFilmler() async{
    var filmlerListesiI = <Filmler>[];
    var f1 = Filmler(filmId: 9, filmResimAdi: "ozark.png");
    var f2 = Filmler(filmId: 10, filmResimAdi: "coffee.png");
    var f3 = Filmler(filmId: 11, filmResimAdi: "boys.png");
    var f4 = Filmler(filmId: 12, filmResimAdi: "ugly.jpg");

    filmlerListesiI.add(f1);
    filmlerListesiI.add(f2);
    filmlerListesiI.add(f3);
    filmlerListesiI.add(f4);

    return filmlerListesiI;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        leading: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0
          ),
          child: SafeArea(child: Image.asset("resimler/netflix.png")),
        ),
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _AppBarButton(tiklama: () => print("Dizilere tıklandı"), yazi: "Diziler"),
            _AppBarButton(tiklama: () => print("Filmler tıklandı"), yazi: "Filmler"),
            _AppBarButton(tiklama: () => print("Listem tıklandı"), yazi: "Listem"),
          ],
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _Yazilar(kelime: "Netflix'te Popüler"),
        _FutureYapisi(fonk_isim: populerFilmler),
        Spacer(flex: 3,),
        _Yazilar(kelime: "Gündemdekiler"),
        _FutureYapisi(fonk_isim:gundemdekiFilmler),
        Spacer(flex: 3,),
        _Yazilar(kelime: "Yeniden İzleyin"),
        _FutureYapisi(fonk_isim:izlenilenFilmler),
        Spacer(flex: 3,),
      ],
      ),


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Anasayfa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Ara",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv_sharp),
            label: "Çok Yakında",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_sharp),
            label: "İndirilenler",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Daha Fazla",
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },

      ),
    );
  }
}

//appbardaki butonlar için
class _AppBarButton extends StatelessWidget { //Sadece bu sayfadan ulaşılsınız diye private yaptım.
  final Function tiklama;
  final String yazi;

  _AppBarButton({required this.tiklama,required this.yazi});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tiklama,
      child: Text(yazi,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w300),),
    );




  }
}

// listeler için
class _FutureYapisi extends StatelessWidget {
  Function fonk_isim ;


  _FutureYapisi({required this.fonk_isim});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Filmler>>(
      future: fonk_isim(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          var filmlerListesi = snapshot.data;
          return SizedBox(width: 400,height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filmlerListesi!.length,
              itemBuilder: (context,indeks) {
                var film = filmlerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    print("Şu resime tıklandı : ${film.filmResimAdi}");
                  },
                  child:
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    height: 100.0,
                    width: 110.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('resimler/${film.filmResimAdi}'),
                          fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),
          );
        }
        else{
          return  Center();
        }
      },

    );


  }
}


// Başlıklar için
class _Yazilar extends StatelessWidget {
  String kelime;


  _Yazilar({required this.kelime});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0,top: 4.0),
          child: Text(kelime,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
