import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

const String tableName = 'items';
const String colLetter = 'firstLetter';
const String colDescription = 'description';

class SqliteHelper {
  late Database _database;

  Future<void> open() async {
    _database = await openDatabase(
      'local_db.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE $tableName ('
            '$colLetter TEXT NOT NULL,'
            '$colDescription TEXT NOT NULL'
            ')');
        // Insert default values into the table
        await insertInitialData(db);
      },
    );
  }

  Future<void> insertInitialData(Database db) async {
    Map<String, String> data = {
      'A': 'Courageous warrior and central character in the Mahabharata, symbolizes bravery and skill in archery.',
      'B': 'The creator god in Hindu mythology, representing creativity and knowledge.',
      'C': 'The moon god, symbolizing beauty, calmness, and serenity.',
      'D': 'The fierce goddess representing strength, protection, and motherhood; she symbolizes the victory of good over evil.',
      'E': 'A term used for God in Hinduism, representing the supreme being or universal spirit.',
      'F': 'Another name for Arjuna, derived from the month of Phalgun, symbolizing the importance of duty (dharma).',
      'G': 'The elephant-headed god of wisdom and new beginnings; he signifies intellect, learning, and the removal of obstacles.',
      'H': 'The monkey god and devoted follower of Lord Rama, representing strength, devotion, and loyalty.',
      'I': 'King of the gods and god of rain and thunderstorms, symbolizing power and authority.',
      'J': 'Another name for Sita, wife of Lord Rama, representing virtue, devotion, and resilience.',
      'K': 'An avatar of Vishnu, known for his charm, wisdom, and role as a divine lover; he symbolizes love and compassion.',
      'L': 'Goddess of wealth and prosperity, representing abundance and good fortune.',
      'M': 'A deity associated with war and victory; he symbolizes courage and leadership.',
      'N': 'Another name for Vishnu, representing preservation, protection, and the cosmic order.',
      'O': 'The sacred sound and spiritual symbol in Hinduism, representing the essence of the ultimate reality (Brahman).',
      'P': 'The goddess of love and devotion, representing fertility, marital bliss, and spiritual attainment.',
      'Q': 'A sage known for his contributions to philosophy and the Samkhya school of thought, symbolizing wisdom and enlightenment.',
      'R': 'An avatar of Vishnu, known for his righteousness and adherence to dharma; he symbolizes the ideal man and king.',
      'S': 'The goddess of knowledge, music, and arts, representing wisdom, creativity, and learning.',
      'T': 'A goddess associated with protection and guidance, often depicted as a star, symbolizing hope and safety.',
      'U': 'Another name for Parvati, symbolizing the divine feminine and maternal aspects.',
      'V': 'The preserver god in the Hindu trinity, representing protection, maintenance, and sustenance of the universe.',
      'W': 'The god of water and celestial ocean, representing cosmic order and moral authority.',
      'X': 'The sun god, symbolizing light, knowledge, and life; he represents the source of energy and enlightenment.',
      'Y': 'The sacred river and a goddess, symbolizing purity, life, and sustenance.',
      'Z': 'A lesser-known figure in Hindu mythology representing the eternal quest for knowledge.'
    };

    data.forEach((letter, description) async {
      await db.insert(tableName, {colLetter: letter, colDescription: description});
    });
  }

  Future<String> fetchDescription(String firstLetter) async {
    await open();
    List<Map> result = await _database.query(tableName, 
      where: '$colLetter = ?', 
      whereArgs: [firstLetter.toUpperCase()]
    );
    if (result.isNotEmpty) {
      return result.first[colDescription] as String;
    } else {
      return 'Description not found for the letter $firstLetter.';
    }
  }
}