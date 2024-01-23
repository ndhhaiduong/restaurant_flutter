import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../data/models/auth.dart';
import '../../utils/popUp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({this.username = ''});

  final String username;

  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  // Initially password is obscure
  bool _obscureText = true;

  final formKey = GlobalKey<FormState>();
  //final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _controllerUsername = new TextEditingController();
  final TextEditingController _controllerPassword = new TextEditingController();

  @override
  initState() {
    super.initState();
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              //Navigator.of(context).pushNamed('/table');
            }),
        centerTitle: true,
        title: Text(
          'Thanh toán',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          //margin: EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              // Xử lý sự kiện khi nút được nhấn
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(16.0),
              minimumSize: Size(double.infinity, 0),
              primary: Colors.blue,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              'Hoàn thành',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
      body: PaymentWidget(),
    );
  }
}

class PaymentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(
                            'Tổng đơn'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Tổng tiền hàng',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Color.fromARGB(
                                                      255, 2, 2, 2),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                margin:
                                                    EdgeInsets.only(left: 5.0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: const Color.fromARGB(
                                                      255,
                                                      213,
                                                      213,
                                                      214), // Màu nền của hình tròn
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '5', // Số bạn muốn hiển thị
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              131,
                                                              129,
                                                              129), // Màu chữ
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ])
                                      ],
                                    ),
                                    Text(
                                      '180,000',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Color.fromARGB(255, 2, 2, 2)),
                                    ),
                                  ])),
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 0.0),
                              child: FDottedLine(
                                color: Color.fromARGB(255, 183, 184, 184),
                                width: double.infinity,
                                strokeWidth: 1.0,
                                dottedLength: 8.0,
                                space: 2.0,
                              )),
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromARGB(255, 183, 184, 184),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Giảm giá',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color.fromARGB(255, 2, 2, 2),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons
                                                .create, // Chọn biểu tượng bạn muốn sử dụng
                                            color: Color.fromARGB(255, 2, 2,
                                                2), // Màu sắc của biểu tượng
                                          ),
                                          SizedBox(
                                              width:
                                                  8.0), // Khoảng trống giữa biểu tượng và văn bản
                                          Text(
                                            '0',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color:
                                                  Color.fromARGB(255, 2, 2, 2),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ])),
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromARGB(255, 183, 184, 184),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Khách cần trả',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 2, 2, 2),
                                      ),
                                    ),
                                    Text(
                                      '180,000',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 2, 2, 2),
                                      ),
                                    ),
                                  ])),
                        ]))
                  ]),
                  Row(children: [
                    Expanded(
                        child: Column(children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        margin: EdgeInsets.only(top: 6.0, bottom: 6.0),
                        child: Text(
                          'Phương thức'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý sự kiện khi nút được nhấn
                              print('Nút được nhấn!');
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Đặt góc bo tròn
                                  side: BorderSide(
                                      color: Color.fromARGB(255, 80, 80,
                                          80)), // Đặt màu đường biên
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 255, 255, 255)),
                            ),
                            child: Text(
                              'Tiền mặt',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 2, 2, 2),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý sự kiện khi nút được nhấn
                              print('Nút được nhấn!');
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Đặt góc bo tròn
                                  side: BorderSide(
                                      color: Color.fromARGB(255, 80, 80,
                                          80)), // Đặt màu đường biên
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 255, 255, 255)),
                            ),
                            child: Text(
                              'Chuyển khoản',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 2, 2, 2),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý sự kiện khi nút được nhấn
                              print('Nút được nhấn!');
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Đặt góc bo tròn
                                  side: BorderSide(
                                      color: Color.fromARGB(255, 80, 80,
                                          80)), // Đặt màu đường biên
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 255, 255, 255)),
                            ),
                            child: Text(
                              'Thẻ',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 2, 2, 2),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý sự kiện khi nút được nhấn
                              print('Nút được nhấn!');
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Đặt góc bo tròn
                                  side: BorderSide(
                                      color: Color.fromARGB(255, 80, 80,
                                          80)), // Đặt màu đường biên
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 255, 255, 255)),
                            ),
                            child: Text(
                              'Kết hợp',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 2, 2, 2),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]))
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            margin: EdgeInsets.only(top: 6.0, bottom: 6.0),
                            child: Text(
                              'Thanh Toán'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromARGB(255, 183, 184, 184),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tiền khách trả',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color.fromARGB(255, 2, 2, 2),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '180,000',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ])),
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromARGB(255, 183, 184, 184),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tiền thừa trả khách',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 2, 2, 2),
                                      ),
                                    ),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 2, 2, 2),
                                      ),
                                    ),
                                  ])),
                        ]))
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
