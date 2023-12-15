import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticChart extends StatefulWidget {
  @override
  _StatisticChartState createState() => _StatisticChartState();
}

class _StatisticChartState extends State<StatisticChart>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool animate = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
  }

  BarChartGroupData _buildBarChartGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          colors: [color.withOpacity(1.0)],
          width: 16,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }

  BarChartGroupData _buildAnimatedBarChartGroupData(
      int x, double y, Color color, Animation<double> animation) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          colors: [color.withOpacity(animation.value)],
          width: 16,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }

  BarChartData _buildStaticChartData() {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 6,
      titlesData: FlTitlesData(
        leftTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          margin: 8,
          getTextStyles: (value, _) => const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          margin: 8,
          getTextStyles: (value, _) => const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: const Color(0xff37434d),
          width: 1,
        ),
      ),
      barGroups: [
        _buildBarChartGroupData(0, 3, Color(0xff2196f3)),
        _buildBarChartGroupData(1, 2, Color(0xff4caf50)),
        _buildBarChartGroupData(2, 5, Color(0xffff9800)),
      ],
    );
  }

  BarChartData _buildAnimatedChartData() {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 6,
      titlesData: FlTitlesData(
        leftTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          margin: 8,
          getTextStyles: (value, _) => const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          margin: 8,
          getTextStyles: (value, _) => const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: const Color(0xff37434d),
          width: 1,
        ),
      ),
      barGroups: [
        _buildAnimatedBarChartGroupData(
            0, 1, Color(0xff2196f3), _animationController.view),
        _buildAnimatedBarChartGroupData(
            1, 5, Color(0xff4caf50), _animationController.view),
        _buildAnimatedBarChartGroupData(
            2, 2.7, Color(0xffff9800), _animationController.view),
        // Barras adicionales para una animación más dinámica
        _buildAnimatedBarChartGroupData(
            3, 4, Color(0xffe91e63), _animationController.view),
        _buildAnimatedBarChartGroupData(
            4, 4.5, Color(0xff795548), _animationController.view),
        _buildAnimatedBarChartGroupData(
            5, 5.8, Color(0xff00bcd4), _animationController.view),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 14.0,
      margin: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Gráfico Estadístico de Usuarios',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Container(
              height: 550.0,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return BarChart(
                    animate
                        ? _buildAnimatedChartData()
                        : _buildStaticChartData(),
                  );
                },
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  animate = !animate;
                  if (animate) {
                    _animationController.forward(from: 0.0);
                  } else {
                    _animationController.reverse(from: 1.0);
                  }
                });
              },
              child: Text(animate ? 'Mostrar Presente' : 'Mostrar Estimado'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
