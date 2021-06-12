import 'package:flutter/material.dart';
import '../model/filter.dart';

// Filter Bar Setup

const _boldStyle = TextStyle(fontWeight: FontWeight.bold);

class FilterBar extends StatelessWidget {
  FilterBar({@required VoidCallback onPressed, Filter filter})
      : _onPressed = onPressed,
        _filter = filter;

  final VoidCallback _onPressed;
  final Filter _filter;

  List<InlineSpan> _buildCategorySpans(Filter filter) {
    final noneSelected =
        filter == null || filter.isDefault || filter.category == null;
    return [
      if (noneSelected) TextSpan(text: 'All Restaurants', style: _boldStyle),
      if (!noneSelected) ...[
        TextSpan(text: '${filter.category}', style: _boldStyle),
        TextSpan(text: ' places'),
      ],
    ];
  }

  List<InlineSpan> _buildPriceSpans(Filter filter) {
    return [
      if (filter.price != null) ...[
        TextSpan(text: ' of '),
        TextSpan(text: '\$' * filter.price, style: _boldStyle),
      ],
    ];
  }

  List<InlineSpan> _buildTitleSpans(Filter filter) {
    return [
      ..._buildCategorySpans(filter),
      if (filter != null && !filter.isDefault) ..._buildPriceSpans(filter),
    ];
  }

  List<InlineSpan> _buildCitySpans(Filter filter) {
    return [
      if (filter.city != null) ...[
        TextSpan(text: 'in '),
        TextSpan(text: '${filter.city} ', style: _boldStyle),
      ],
    ];
  }

  List<InlineSpan> _buildSubtitleSpans(Filter filter) {
    final orderedByRating =
        filter == null || filter.sort == null || filter.sort == 'avgRating';
    return [
      if (filter != null) ..._buildCitySpans(filter),
      if (orderedByRating) TextSpan(text: 'by rating'),
      if (!orderedByRating) TextSpan(text: 'by # reviews'),
    ];
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    padding: EdgeInsets.all(6),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  //Changed FlatButton to TextButton and removed the following: color: Colors.white, padding: EdgeInsets.all(6),
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
      ),
      onPressed: _onPressed,
      child: Row(
        children: [
          Icon(Icons.filter_list),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: _buildTitleSpans(_filter),
                    ),
                  ),
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.caption,
                      children: _buildSubtitleSpans(_filter),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
