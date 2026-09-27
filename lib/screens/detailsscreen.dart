import 'package:flutter/material.dart';
import 'package:movie_search_app/models/favprovider.dart';
import 'package:movie_search_app/models/moviemodel.dart';
import 'package:provider/provider.dart';

class detailscreen extends StatefulWidget {
  moviemodel m;

  detailscreen({
    super.key,
    required this.m,
  });

  @override
  State<detailscreen> createState() => _detailscreenState();
}

class _detailscreenState extends State<detailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ================= POSTER =================
              Stack(
                children: [

                  SizedBox(
                    width: double.infinity,
                    height: 290,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                      child: Image.network(
                        widget.m.imageurl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Dark gradient at bottom of poster
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 100,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Back button
                  Positioned(
                    top: 8,
                    left: 4,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),

                  // Favourite button
                  Positioned(
                    top: 8,
                    right: 4,
                    child: IconButton(
                      onPressed: () {
                        if(!widget.m.isadded){
                          context.read<favprovider>().add(widget.m);
                          setState(() {
                            widget.m.isadded=true;
                          });
                        }
                        else if(widget.m.isadded){
                          context.read<favprovider>().remove(widget.m);
                          setState(() {
                            widget.m.isadded=false;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: widget.m.isadded
                            ? Colors.redAccent
                            : Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),

              // ================= MOVIE NAME =================
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 4,
                ),
                child: Text(
                  widget.m.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // ================= RATING =================
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  top: 2,
                ),
                child: Row(
                  children: [
                    const Text(
                      "⭐",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(width: 3),

                    Text(
                      widget.m.rating.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ================= GENRES =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: widget.m.gene.map((genre) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _genreContainer(genre),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 18),

              // ================= OVERVIEW =================
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Overview",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // ================= SUMMARY =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  widget.m.summary,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ================= GENRE WIDGET =================
  Widget _genreContainer(String text) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 12),

      decoration: BoxDecoration(
        color: const Color(0xFF0B161E),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF172A3A),
        ),
      ),

      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFFC5D5E5),
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}