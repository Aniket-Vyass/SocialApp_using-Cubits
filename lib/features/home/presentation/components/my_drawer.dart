import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_social_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:small_social_app/features/home/presentation/components/my_drawer_tile.dart';
import 'package:small_social_app/features/profile/presentation/pages/profile_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Drawer(
        backgroundColor: colorScheme.surface,
        width: 285,
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────────────────
            _DrawerHeader(),

            // ── Nav Items ───────────────────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 8),

                    MyDrawerTile(
                      title: 'H O M E',
                      icon: Icons.home_rounded,
                      onTap: () => Navigator.of(context).pop(),
                    ),

                    MyDrawerTile(
                      title: 'P R O F I L E',
                      icon: Icons.person_rounded,
                      onTap: () {
                        final user = context.read<AuthCubit>().currentUser;
                        String? uid = user!.uid;
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(uid: uid),
                          ),
                        );
                      },
                    ),

                    MyDrawerTile(
                      title: 'S E A R C H',
                      icon: Icons.search_rounded,
                      onTap: null,
                    ),

                    MyDrawerTile(
                      title: 'S E T T I N G S',
                      icon: Icons.settings_rounded,
                      onTap: () {},
                    ),

                    const Spacer(),

                    // ── Divider before logout ──────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        color: colorScheme.outlineVariant.withOpacity(0.5),
                        thickness: 1,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // ── Logout ─────────────────────────────────────────
                    _LogoutTile(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Header Widget ────────────────────────────────────────────────────────────

class _DrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 36, 24, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [colorScheme.primary.withOpacity(0.15), colorScheme.surface]
              : [colorScheme.primary.withOpacity(0.08), colorScheme.surface],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar with gradient ring
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 34,
              backgroundColor: colorScheme.surfaceContainerHighest,
              child: Icon(
                Icons.person_rounded,
                size: 36,
                color: colorScheme.primary,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // App / brand label
          Text(
            'Menu',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            'Navigate your world',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              letterSpacing: 0.3,
            ),
          ),

          const SizedBox(height: 20),

          Divider(
            color: colorScheme.outlineVariant.withOpacity(0.6),
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

// ── Logout Tile ──────────────────────────────────────────────────────────────

class _LogoutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          final authCubit = context.read<AuthCubit>();
          authCubit.logout();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: colorScheme.errorContainer.withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: colorScheme.error.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.error.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.logout_rounded,
                  size: 20,
                  color: colorScheme.error,
                ),
              ),
              const SizedBox(width: 14),
              Text(
                'L O G O U T',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colorScheme.error,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:small_social_app/features/auth/presentation/cubits/auth_cubit.dart';
// import 'package:small_social_app/features/home/presentation/components/my_drawer_tile.dart';
// import 'package:small_social_app/features/profile/presentation/pages/profile_page.dart';

// class MyDrawer extends StatelessWidget {
//   const MyDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Drawer(
//         //column should be wrapped with safearea
//         backgroundColor: Theme.of(context).colorScheme.surface,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 25.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 50),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Icon(
//                   Icons.person,
//                   size: 80,
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//               ),

//               //Divider line
//               Divider(color: Theme.of(context).colorScheme.secondary),

//               //home tile
//               MyDrawerTile(
//                 title: 'H O M E',
//                 icon: Icons.home,
//                 onTap: () => Navigator.of(context).pop(),
//               ),

//               //Profile tile
//               MyDrawerTile(
//                 title: 'P R O F I L E',
//                 icon: Icons.home,
//                 onTap: () {
//                   //get current user id
//                   final user = context.read<AuthCubit>().currentUser;
//                   String? uid = user!.uid;
//                   //pop menu drawer
//                   Navigator.of(context).pop();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ProfilePage(uid: uid),
//                     ),
//                   );
//                 },
//               ),

//               //search tiles
//               MyDrawerTile(
//                 title: 'S E A R C H',
//                 icon: Icons.search,
//                 onTap: null,
//               ),

//               //settings tile
//               MyDrawerTile(
//                 title: 'S E T T I N G S',
//                 icon: Icons.settings,
//                 onTap: () {},
//               ),

//               //spacer
//               const Spacer(),

//               //logout tile
//               MyDrawerTile(
//                 title: 'L O G O U T',
//                 icon: Icons.logout,
//                 onTap: () {
//                   final authCubit = context.read<AuthCubit>();
//                   authCubit.logout();
//                 },
//               ),

//               SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
