import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sonicflow/main.dart';
import 'package:sonicflow/services/storage_service.dart'; // Make sure to import the StorageService

// Create a fake or mock instance of StorageService for testing
class FakeStorageService extends StorageService {
  @override
  Future<void> init() async {
    // You can mock any methods or just override them if needed.
  }
}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create a fake storage service instance
    final storageService = FakeStorageService();

    // Build our app and trigger a frame with the fake storage service
    await tester.pumpWidget(MyApp(storageService: storageService));

    // Verify that the app starts with the expected initial state (assuming you have a counter that starts at 0)
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
