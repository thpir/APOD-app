import 'package:apod/ui/screens/apod_screen.dart';
import 'package:apod/ui/screens/ar_solar_screen.dart';
import 'package:apod/ui/screens/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;


class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(12.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/launcher_icon/launcher_icon.png'),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
        title: const Text('Cosmos App'),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  _RowConstraints(
                    child: _HomeTile(
                      cardNavigation: () {
                        Navigator.pushNamed(context, ApodScreen.routeName);
                      },
                      imagePath: 'assets/images/dawn_of_a_sunlike_star.png',
                      centerChild: Text(
                        'APOD',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      tileTitle: 'Astronomy Picture of the Day',
                    ),
                  ),
                  _RowConstraints(
                    child: Row(
                      spacing: 8,
                      children: [
                        Expanded(
                          child: _HomeTile(
                            cardNavigation: () {
                              Navigator.pushNamed(context, NewsScreen.routeName);
                            }, 
                            tileTitle: 'Space News',
                            imagePath: 'assets/images/starburst_galaxy_ngc_1569.png',
                            centerChild: Icon(
                              Icons.newspaper_outlined,
                              size: 48,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        Expanded(
                          child: _HomeTile(
                            cardNavigation: () {
                              Navigator.pushNamed(context, ArSolarScreen.routeName);
                            }, 
                            tileTitle: 'AR Solar System',
                            imagePath: 'assets/images/sbh_in_early_universe.png',
                            centerChild: Icon(
                              Icons.view_in_ar_outlined,
                              size: 48,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeTile extends StatelessWidget {
  final VoidCallback cardNavigation;
  final String? imagePath;
  final Widget? centerChild;
  final String tileTitle;
  const _HomeTile({
    required this.cardNavigation,
    this.imagePath,
    this.centerChild,
    required this.tileTitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cardNavigation,
      child: shadcn.Card(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(4),
        filled: true,
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: imagePath != null
                ? DecorationImage(
                    image: AssetImage(imagePath!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          alignment: Alignment.center,
          child: Stack(
            children: [
              Center(child: centerChild),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: double.infinity,
                  color: Colors.black.withAlpha(80),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      tileTitle,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RowConstraints extends StatelessWidget {
  final Widget? child;
  const _RowConstraints({this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 300, maxWidth: 600),
      child: child,
    );
  }
}
