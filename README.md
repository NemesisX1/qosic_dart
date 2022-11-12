# Qosic Dart

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

A Very Good Project created by Very Good CLI.

## About ❓

This package is a simple way to handle [Qosic](http://qosic.com)'s USSD payment. It allows you to integrate mobile money payment into your Dart and Flutter app.

🚨  **WARNING** 🚨
**This client should only be used on the server side.**

## Installation 💻

**❗ In order to start using Qosic Dart you must have the [Dart SDK][dart_install_link] installed on your machine.**

Add `qosic_dart` to your `pubspec.yaml`:

```yaml
dependencies:
  qosic_dart:
```

Install it:

```sh
dart pub get qosic_dart
```

---

## Usage 🔨



### Make a payment

A simple example of how to compute a USSD payment with QOSIC

```dart

final qosic = QosicDart(
  moovKey: 'XXXXXXXXXx',
  mtnKey: 'XXXXXXXXXX',
  username: 'XXXXXXXXXX',
  password: 'XXXXXXXXX',
);

final transactionRef = await qosic.pay(
    network: QosicNetwork.mtn,
    phoneNumber: 'XXXXXXXX', /// precedeed by the country code. ex: 229XXXXXXXX
    amount: '1',
  );

Timer.periodic(
    const Duration(
      seconds: 10, /// feel free to give your own second to wait
                   /// but I will advice you between 7 and 10 secs
    ),
    (timer) async {
      final status = await qosic.getPaymentStatus(
        transactionReference: transactionRef!,
        network: QosicNetwork.mtn,
        country: QosicCountry.benin,
      );

      if (status == QosicStatus.successfull || status == QosicStatus.failed) {
        timer.cancel();
        if (status == QosicStatus.successfull) {
          log("Success for payment");
        } else {
          log("Payment failed");
        }
      }
    },
);

```

---

## Continuous Integration 🤖

Qosic Dart comes with a built-in [GitHub Actions workflow][github_actions_link] powered by [Very Good Workflows][very_good_workflows_link] but you can also add your preferred CI/CD solution.

Out of the box, on each pull request and push, the CI `formats`, `lints`, and `tests` the code. This ensures the code remains consistent and behaves correctly as you add functionality or make changes. The project uses [Very Good Analysis][very_good_analysis_link] for a strict set of analysis options used by our team. Code coverage is enforced using the [Very Good Workflows][very_good_coverage_link].

---

## Running Tests 🧪

To run all unit tests:

```sh
dart pub global activate coverage 1.2.0
dart test --coverage=coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
open coverage/index.html
```

[dart_install_link]: https://dart.dev/get-dart
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows

