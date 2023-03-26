import 'package:flutter/material.dart';
import 'package:ogrenci_app/repository/ogrenciler_repo.dart';

class OgrencilerSayfasi extends StatefulWidget {
  final OgrencilerRepository ogrencilerRepository;
  const OgrencilerSayfasi(this.ogrencilerRepository, {Key? key}) : super(key: key);

  @override
  State<OgrencilerSayfasi> createState() => _OgrencilerSayfasiState();
}

class _OgrencilerSayfasiState extends State<OgrencilerSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Öğrenciler")),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                child: Text(
                  "${widget.ogrencilerRepository.ogrenciler.length} Öğrenci"
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) =>  OgrenciSatiri(
                  widget.ogrencilerRepository.ogrenciler[index],
                  widget.ogrencilerRepository,
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: widget.ogrencilerRepository.ogrenciler.length)
          ),
        ],
      ),
    );
  }
}

class OgrenciSatiri extends StatefulWidget {
  final Ogrenci ogrenci;
  final OgrencilerRepository ogrencilerRepository;
  const OgrenciSatiri(this.ogrenci, this.ogrencilerRepository , {
    super.key,
  });

  @override
  State<OgrenciSatiri> createState() => _OgrenciSatiriState();
}

class _OgrenciSatiriState extends State<OgrenciSatiri> {
  @override
  Widget build(BuildContext context) {
    bool seviyorMu = widget.ogrencilerRepository.seviyorMu(widget.ogrenci);
    return ListTile(
      title: Text(widget.ogrenci.ad + " " + widget.ogrenci.soyad),
      leading: Text(widget.ogrenci.cinsiyet == "Kadın" ? "👩" : "👨" ), //👩👨
      trailing: IconButton(
          onPressed: () {
            setState(() {
            widget.ogrencilerRepository.sev(widget.ogrenci,!seviyorMu);
            });
          },
          icon: Icon(
              seviyorMu ? Icons.favorite : Icons.favorite_border)),
    );
  }
}
