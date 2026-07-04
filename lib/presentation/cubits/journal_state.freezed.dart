// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$JournalState {
  List<Journal> get journals => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $JournalStateCopyWith<JournalState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JournalStateCopyWith<$Res> {
  factory $JournalStateCopyWith(
          JournalState value, $Res Function(JournalState) then) =
      _$JournalStateCopyWithImpl<$Res, JournalState>;
  @useResult
  $Res call({List<Journal> journals});
}

/// @nodoc
class _$JournalStateCopyWithImpl<$Res, $Val extends JournalState>
    implements $JournalStateCopyWith<$Res> {
  _$JournalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? journals = null,
  }) {
    return _then(_value.copyWith(
      journals: null == journals
          ? _value.journals
          : journals // ignore: cast_nullable_to_non_nullable
              as List<Journal>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JournalStateImplCopyWith<$Res>
    implements $JournalStateCopyWith<$Res> {
  factory _$$JournalStateImplCopyWith(
          _$JournalStateImpl value, $Res Function(_$JournalStateImpl) then) =
      __$$JournalStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Journal> journals});
}

/// @nodoc
class __$$JournalStateImplCopyWithImpl<$Res>
    extends _$JournalStateCopyWithImpl<$Res, _$JournalStateImpl>
    implements _$$JournalStateImplCopyWith<$Res> {
  __$$JournalStateImplCopyWithImpl(
      _$JournalStateImpl _value, $Res Function(_$JournalStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? journals = null,
  }) {
    return _then(_$JournalStateImpl(
      journals: null == journals
          ? _value._journals
          : journals // ignore: cast_nullable_to_non_nullable
              as List<Journal>,
    ));
  }
}

/// @nodoc

class _$JournalStateImpl implements _JournalState {
  _$JournalStateImpl({required final List<Journal> journals})
      : _journals = journals;

  final List<Journal> _journals;
  @override
  List<Journal> get journals {
    if (_journals is EqualUnmodifiableListView) return _journals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_journals);
  }

  @override
  String toString() {
    return 'JournalState(journals: $journals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JournalStateImpl &&
            const DeepCollectionEquality().equals(other._journals, _journals));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_journals));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JournalStateImplCopyWith<_$JournalStateImpl> get copyWith =>
      __$$JournalStateImplCopyWithImpl<_$JournalStateImpl>(this, _$identity);
}

abstract class _JournalState implements JournalState {
  factory _JournalState({required final List<Journal> journals}) =
      _$JournalStateImpl;

  @override
  List<Journal> get journals;
  @override
  @JsonKey(ignore: true)
  _$$JournalStateImplCopyWith<_$JournalStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
