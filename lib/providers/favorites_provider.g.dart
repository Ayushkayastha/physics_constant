// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoritesNotifier)
const favoritesProvider = FavoritesNotifierProvider._();

final class FavoritesNotifierProvider
    extends $NotifierProvider<FavoritesNotifier, List<ConstantModel>> {
  const FavoritesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesNotifierHash();

  @$internal
  @override
  FavoritesNotifier create() => FavoritesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ConstantModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ConstantModel>>(value),
    );
  }
}

String _$favoritesNotifierHash() => r'792071c5de3330b32b34e3e8710174305d7ae5fb';

abstract class _$FavoritesNotifier extends $Notifier<List<ConstantModel>> {
  List<ConstantModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<ConstantModel>, List<ConstantModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ConstantModel>, List<ConstantModel>>,
              List<ConstantModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
