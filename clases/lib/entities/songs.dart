class Song {
  final int id;
  final String name;
  final String artist;
  final String album;
  final String cover;

  Song(this.id, this.name, this.artist, this.album, this.cover);
}

final List<Song> songs = [
    Song(1, "Ciudad mágica", "Tan Bionica", "Destinologia", "https://cdn-images.dzcdn.net/images/cover/7e91c7d5967661dbcf0c8825666fa4ec/1900x1900-000000-80-0-0.jpg"),
    Song(2, "Espresso", "Sabrina Carpenter", "Short & Sweet", "https://cdn-images.dzcdn.net/images/cover/0fd6e3b346b959a8781ccfa89b63607a/500x500-000000-80-0-0.jpg"),
    Song(3, "Supernatural", "Ariana Grande", "eternal sunshine", "https://cdn-images.dzcdn.net/images/cover/9349b2fcb4bd060060a33f054a619e83/0x1900-000000-80-0-0.jpg"),
    Song(4, "vampire", "Olivia Rodrigo", "GUTS (spilled)", "https://cdn-images.dzcdn.net/images/cover/a556f7f5fb3efeedb984ad5951f38f21/0x1900-000000-80-0-0.jpg"),
    Song(5, "Risk", "Gracie Abrams", "The Secret of Us", "https://cdn-images.dzcdn.net/images/cover/bad43fd5d83235591fbcb0132c5f1a35/0x1900-000000-80-0-0.jpg"),
  ];