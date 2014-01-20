(function() {
  var draw_bargraph, draw_scatter;

  $('.btn').on('click', function() {
    var button, rows;
    button = $(this);
    rows = $('#data-amount').val() || 50;
    return $.ajax({
      type: 'POST',
      url: 'php/get_data.php',
      dataType: 'json',
      success: function(data) {
        $('.output').html('');
        if (button.hasClass('btn-bargraph')) return draw_bargraph(data);
      }
    });
  });

  draw_bargraph = function(data) {
    var bar_padding, h, svg, view_padding, w, yAxis, yScale;
    w = 400;
    h = 100;
    bar_padding = 0;
    view_padding = 30;
    yScale = d3.scale.linear().domain([
      0, d3.max(data, function(d) {
        return d['ts'];
      })
    ]).range([view_padding, h - view_padding / 10]);
    yAxis = d3.svg.axis().scale(yScale).orient('left').ticks(5);
    svg = d3.select('.output').append('svg').attr('width', w).attr('height', h);
    svg.attr('class', 'bargraph');
    svg.selectAll('rect').data(data).enter().append("rect").attr('x', function(d, i) {
      return i * (w / data.length);
    }).attr('y', function(d, i) {
      return h;
    }).attr('fill', 'rgb(0, 100, 250)');
    svg.selectAll('rect').transition().duration(700).attr("x", function(d, i) {
      return i * (w / data.length);
    }).attr("y", function(d) {
      return h - (yScale(d['ts']));
    }).attr('width', w / data.length - bar_padding).attr('height', function(d) {
      return yScale(d['ts']);
    });
    return svg.append('g').attr('class', 'axis').attr('transform', "translate(0, " + (h - view_padding) + ")").call(yAxis);
  };

  draw_scatter = function(data) {
    var bar_padding, h, rScale, svg_scatter, view_padding, w, xAxis, xScale, yAxis, yScale;
    w = 1100;
    h = 400;
    bar_padding = 1;
    view_padding = 25;
    xScale = d3.scale.linear().domain([
      d3.min(data, function(d) {
        return d['value'];
      }), d3.max(data, function(d) {
        return d['value'];
      })
    ]).range([view_padding, w - view_padding * 2]);
    yScale = d3.scale.linear().domain([8, 11]).range([h - view_padding, view_padding]);
    rScale = d3.scale.linear().domain([
      0, d3.max(data, function(d) {
        return d['temp'];
      })
    ]).range([2, 5]);
    xAxis = d3.svg.axis().scale(xScale).orient('bottom');
    yAxis = d3.svg.axis().scale(yScale).orient('left').ticks(5);
    svg_scatter = d3.select('.output').append('svg').attr('width', w).attr('height', h);
    svg_scatter.selectAll('circle').data(data).enter().append('circle').attr('cx', function(d) {
      return xScale(d['humidity']);
    }).attr('cy', function(d) {
      return yScale(d['temp']);
    }).attr('r', function(d) {
      return rScale(d['temp']);
    });
    svg_scatter.append('g').attr('class', 'axis').attr('transform', "translate(0, " + (h - view_padding) + ")").call(xAxis);
    return svg_scatter.append('g').attr('class', 'axis').attr('transform', "translate(" + view_padding + ",0)").call(yAxis);
  };

}).call(this);
