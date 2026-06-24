import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));
  
  for (final file in files) {
    String content = file.readAsStringSync();
    bool changed = false;
    
    if (content.contains('.withOpacity(')) {
      content = content.replaceAllMapped(RegExp(r'\.withOpacity\(([^)]+)\)'), (match) {
        return '.withValues(alpha: ${match.group(1)})';
      });
      changed = true;
    }
    
    if (content.contains('__')) {
      content = content.replaceAll('_, __, ___', '_, _, _');
      content = content.replaceAll('_, __', '_, _');
      content = content.replaceAll('(__)', '(_)');
      changed = true;
    }
    
    if (changed) {
      file.writeAsStringSync(content);
      print('Fixed ${file.path}');
    }
  }
}
