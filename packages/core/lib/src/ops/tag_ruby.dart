part of '../core_widget_factory.dart';

const _kTagRuby = 'ruby';
const _kTagRp = 'rp';
const _kTagRt = 'rt';

class _TagRuby {
  final WidgetFactory wf;

  _TagRuby(this.wf);

  BuildOp get buildOp {
    TextBits rtText;

    return BuildOp(
      onChild: (meta, e) {
        switch (e.localName) {
          case _kTagRp:
            meta = lazySet(meta, styles: [_kCssDisplay, _kCssDisplayNone]);
            break;
          case _kTagRt:
            meta = lazySet(
              meta,
              buildOp: BuildOp(
                onPieces: (_, pieces) {
                  for (final piece in pieces) {
                    if (piece.hasWidgets) continue;
                    rtText = piece.text..detach();
                    break;
                  }

                  return [];
                },
              ),
              styles: [_kCssFontSize, '0.5em'],
            );
            break;
        }

        return meta;
      },
      onPieces: (_, pieces) => pieces.map((piece) {
        if (piece.hasWidgets || rtText == null) return piece;
        final _rtText = rtText;
        rtText = null;

        final text = piece.text..trimRight();
        if (text.isEmpty) return piece;

        final parent = text.parent;
        final replacement = parent.sub(text.tsb)..detach();
        text.replaceWith(replacement);

        replacement.add(_buildTextBit(parent, text, _rtText));

        return BuiltPiece.text(replacement);
      }),
    );
  }

  TextBit _buildTextBit(TextBits parent, TextBits ruby, TextBits rt) =>
      TextWidget(
        parent,
        WidgetPlaceholder<_TagRuby>(builder: (context, _, __) {
          final rubyText = wf.buildText(context, null, ruby);
          final rtText = wf.buildText(context, null, rt);
          final rtStyle = rt.tsb.build(context);
          final padding = EdgeInsets.symmetric(
              vertical: rtStyle.fontSize *
                  .75 *
                  MediaQuery.of(context).textScaleFactor);

          return [
            Stack(
              children: <Widget>[
                wf.buildPadding(wf.buildColumn(rubyText), padding),
                Positioned(
                  child: Center(child: wf.buildColumn(rtText)),
                  left: 0,
                  right: 0,
                  top: 0,
                ),
              ],
              overflow: Overflow.visible,
            )
          ];
        }),
        alignment: PlaceholderAlignment.middle,
      );
}
