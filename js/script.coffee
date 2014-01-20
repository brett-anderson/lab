


$('.btn')
  .on('click', () ->
    button = $(this)
    rows = $('#data-amount').val() || 50
    $.ajax
      type: 'POST'
      url: 'php/get_data.php'
      dataType: 'json'

        # query: 'SELECT * FROM "Sensors"'
      success:(data) ->
        $('.output').html('')

        # d['ts'] = d['ts'].substring(11, 22) for d in data 
        draw_bargraph(data) if button.hasClass('btn-bargraph')
        # draw_scatter(data) if button.hasClass('btn-scatter')
  ) 
 
draw_bargraph = (data) ->
  w = 400
  h = 100
  bar_padding = 0
  view_padding = 30

  yScale = d3.scale.linear()
    .domain([0, d3.max(data, (d) -> d['ts'])])
    .range([view_padding, h - view_padding / 10])
    # .clamp(true)

  yAxis = d3.svg.axis()
    .scale(yScale)
    .orient('left')
    .ticks(5)
    # .tickFormat(format_as_percent)

  svg = d3.select('.output')
    .append('svg')
    .attr('width', w)
    .attr('height', h)

  svg.attr('class', 'bargraph')

  svg.selectAll('rect')
    .data(data)
    .enter()
    .append("rect")
    .attr('x', (d, i) -> i * (w / data.length))
    .attr('y', (d, i) -> h)
    .attr('fill', 'rgb(0, 100, 250)')

  svg.selectAll('rect')
    .transition()
    .duration(700)
    # .ease('circle)'
    .attr("x", (d, i) -> i * (w / data.length))
    .attr("y", (d) -> h - (yScale(d['ts'])))
    .attr('width', w / data.length - bar_padding )
    .attr('height', (d) -> yScale(d['ts']))

  svg.append('g')
    .attr('class', 'axis')
    .attr('transform', "translate(0, #{h - view_padding})")
    .call(yAxis)
    # .attr('fill', (d) -> "rgba(0, 100, 250, #{d['value'] / 20})")
  # svg.selectAll('text')
  #   .data(data)
  #   .enter()
  #   .append('text')
  #   .attr('text-anchor', 'middle')
  #   .text( (d) -> d['value'])
  #   .attr('x', (d, i) -> i * (w / data.length) + ( w / data.length - bar_padding) / 2)
  #   .attr('y', (d, i) -> h)
  #   .attr('font-size', (w / data.length) * .5)
  #   .attr('fill', 'white')

  # svg.selectAll('text')
  #   .transition()
  #   .duration(700)
  #   .attr('y', (d) -> h - (d['value'] * 10) + 14)


draw_scatter = (data) ->

  w = 1100
  h = 400
  bar_padding = 1
  view_padding = 25

  # console.lo

  
  xScale = d3.scale.linear()
  .domain([ d3.min(data, (d) -> d['value']), d3.max(data, (d) -> d['value'])])
  .range([view_padding, w - view_padding * 2])

  yScale = d3.scale.linear()
    .domain([8, 11])
    # .domain([0, d3.max(data, (d) -> d['temp'])])
    .range([h - view_padding, view_padding])

  rScale = d3.scale.linear()
    .domain([0, d3.max(data, (d) -> d['temp'])])
    .range([2, 5]);

  xAxis = d3.svg.axis()
    .scale(xScale)
    .orient('bottom')
    # .tickFormat(format_as_percent)

  yAxis = d3.svg.axis()
    .scale(yScale)
    .orient('left')
    .ticks(5)

  svg_scatter = d3.select('.output')
    .append('svg')
    .attr('width', w)
    .attr('height', h)

  svg_scatter.selectAll('circle')
    .data(data)
    .enter()
    .append('circle')
    .attr('cx', (d) -> xScale(d['humidity']))
    .attr('cy', (d) -> yScale(d['temp']))
    .attr('r', (d) -> rScale(d['temp']))

  svg_scatter.append('g')
    .attr('class', 'axis')
    .attr('transform', "translate(0, #{h - view_padding})")
    .call(xAxis)

  svg_scatter.append('g')
    .attr('class', 'axis')
    .attr('transform', "translate(#{view_padding},0)")
    .call(yAxis)