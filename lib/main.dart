import 'package:flutter/material.dart';

void main() {
  runApp(const FitMotionApp());
}

const String logoPath = 'assets/images/unnamed.jpg';

class FitMotionApp extends StatelessWidget {
  const FitMotionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitMotion',
      home: const LoginPage(),
    );
  }
}

//////////////// LOGIN //////////////////

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final user = TextEditingController();
  final pass = TextEditingController();

  final correctUser = "dimas@gmail.com";
  final correctPass = "gym12345";

  void login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (user.text == correctUser &&
        pass.text == correctPass) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainNavigation(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Aduh salah ni brow !",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo,
              Colors.blue,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 55,
                  child: ClipOval(
                    child: Image.asset(
                      logoPath,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "FitMotion",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: user,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email wajib diisi";
                          }

                          if (!RegExp(
                            r'^[^@]+@[^@]+\.[^@]+'
                          ).hasMatch(value)) {
                            return "Format email salah";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: pass,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password wajib diisi";
                          }

                          if (value.length < 8) {
                            return "Minimal 8 karakter";
                          }

                          if (!RegExp(
                            r'^(?=.*[A-Za-z])(?=.*\d).+$'
                          ).hasMatch(value)) {
                            return "Harus huruf dan angka";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: login,
                            child: const Text(
                              "LOGIN",
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Lupa Password?",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//////////////// NAVIGATION //////////////////

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState()
  => _MainNavigationState();
}

class _MainNavigationState
extends State<MainNavigation>{

  int currentIndex=0;
  String userName="Dimas";

  @override
  Widget build(
BuildContext context
  ){
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomePage(
            username:userName,
          ),
          const SchedulePage(),
          ProfilePage(
            username:userName,
            onNameChanged:
            (newName){
              setState(() {
                userName=newName;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar:
      BottomNavigationBar(
        currentIndex:
        currentIndex,
        onTap:(index){
          setState(() {
            currentIndex=index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon:
            Icon(Icons.home),
            label:"Home",
          ),
          BottomNavigationBarItem(
            icon:
            Icon(
              Icons.calendar_month,
            ),
            label:"Schedule",
          ),
          BottomNavigationBarItem(
            icon:
            Icon(Icons.person),
            label:"Profile",
          ),
        ],
      ),
    );
  }
}

//////////////// HOME //////////////////

class HomePage
extends StatefulWidget{
  final String username;
  const HomePage({
    super.key,
    required this.username,
  });

  @override
  State<HomePage> createState()
  => _HomePageState();
}

class _HomePageState
extends State<HomePage>{
  Map<String,bool>
  statusWorkout={
    'Push Up':false,
    'Bench Press':false,
    'Chin Up':false,
    'Lari di Tempat':false,
    'Jumping Jack':false,
    'Jalan di Tempat':false,
    'Stretching 10 Menit':false,
  };

  double getProgress(){
    int done=
    statusWorkout.values
        .where((item)=>item)
        .length;

    return done/
        statusWorkout.length;
  }

  @override
  Widget build(
      BuildContext context
      ){

    double progress=
    getProgress();

    return Scaffold(
      appBar:AppBar(
        title:
        Text(
          "Halo ${widget.username}",
        ),
      ),
      body:Padding(
        padding:
        const EdgeInsets.all(20),
        child:Column(
          children:[
            Container(
              padding:
              const EdgeInsets.all(20),
              decoration:
              BoxDecoration(
                color:Colors.indigo,
                borderRadius:
                BorderRadius.circular(20),
              ),
              child:Column(
                children:[
                  const Text(
                    "Progress Hari Ini",
                    style:TextStyle(
                      color:Colors.white,
                    ),
                  ),
                  const SizedBox(height:15),
                  Text(
                    "${(progress*100).toInt()}%",
                    style:
                    const TextStyle(
                      fontSize:40,
                      color:Colors.white,
                    ),
                  ),
                  LinearProgressIndicator(
                    value:progress,
                  ),
                  const SizedBox(height:15),
                  ElevatedButton.icon(
                    onPressed:(){
                      setState(() {
                        statusWorkout.updateAll(
                              (key,value)=>false,
                        );
                      });
                    },
                    icon:
                    const Icon(
                      Icons.refresh,
                    ),
                    label:
                    const Text(
                      "Reset Progress",
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height:30),
            menuCard(
              context,
              "Main Training",
              Icons.fitness_center,
              [
                "Push Up",
                "Bench Press",
                "Chin Up"
              ],
            ),
            menuCard(
              context,
              "Cardio",
              Icons.directions_run,
              [
                "Lari di Tempat",
                "Jumping Jack",
                "Jalan di Tempat"
              ],
            ),
            menuCard(
              context,
              "Stretching",
              Icons.self_improvement,
              [
                "Stretching 10 Menit"
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuCard(
    BuildContext context,
    String title,
    IconData icon,
    List<String> workouts,
  ){
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child:ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: Icon(icon, size: 36, color: Colors.indigo),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing:
        const Icon(
          Icons.arrow_forward_ios,
        ),
        onTap:() async{
          final result=
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_)=>
                  WorkoutDetailPage(
                    title:title,
                    workouts:workouts,
                    statusMap:
                    statusWorkout,
                  ),
            ),
          );

          if(result!=null){
            setState(() {
              statusWorkout=result;
            });
          }
        },
      ),
    );
  }
}

//////////// WORKOUT DETAIL ////////////

class WorkoutDetailPage
extends StatefulWidget{

  final String title;
  final List<String> workouts;
  final Map<String,bool> statusMap;

  const WorkoutDetailPage({
    super.key,
    required this.title,
    required this.workouts,
    required this.statusMap,
  });

  @override
  State<WorkoutDetailPage>
  createState()
  => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState
extends State<WorkoutDetailPage>{

  late Map<String,bool>
  localStatus;

  @override
  void initState(){
    super.initState();
    localStatus=
        Map.from(
          widget.statusMap,
        );
  }

  @override
  Widget build(
      BuildContext context
      ){

    return Scaffold(
      appBar:AppBar(
        title:
        Text(
          widget.title,
        ),
      ),
      body:ListView.builder(
        itemCount:
        widget.workouts.length,
        itemBuilder:
            (context,index){

          String item=
          widget.workouts[index];

          return Card(
            child:ListTile(
              leading:
              IconButton(
                icon:Icon(
                  Icons.check_circle,
                  color:
                  localStatus[item]!
                      ? Colors.green
                      : Colors.grey,
                ),
                onPressed:(){
                  setState(() {
                    localStatus[item]=
                    !localStatus[item]!;
                  });
                },
              ),
              title:
              Text(
                item,
                style:TextStyle(
                  decoration:
                  localStatus[item]!
                      ? TextDecoration.lineThrough
                      :null,
                ),
              ),
              onTap:(){
                setState(() {
                  localStatus[item]=
                  !localStatus[item]!;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton:
      FloatingActionButton.extended(
        onPressed:(){
          Navigator.pop(
            context,
            localStatus,
          );
        },
        icon:
        const Icon(
          Icons.save,
        ),
        label:
        const Text(
          "Simpan Progress",
        ),
      ),
    );
  }
}

//////////// SCHEDULE ////////////

class SchedulePage
extends StatelessWidget{

  const SchedulePage({
    super.key
  });

  @override
  Widget build(
      BuildContext context
      ){
    return Scaffold(
      appBar:AppBar(
        title:
        const Text(
          "Schedule",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Jadwal Latihan Mu !",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 25),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Senin : Stretch, Chest Day & Pull Day", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                    SizedBox(height: 25),
                    Text("Selasa : Rest Day", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
                    SizedBox(height: 25),
                    Text("Rabu : Stretch, Chest Day", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                    SizedBox(height: 25),
                    Text("Kamis : Stretch, Pull Day", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                    SizedBox(height: 25),
                    Text("Jumat : Stretch, Cardio", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                    SizedBox(height: 25),
                    Text("Sabtu : Rest Day", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
                    SizedBox(height: 25),
                    Text("Minggu : Rest Day", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
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

//////////// PROFILE ////////////

class ProfilePage
extends StatelessWidget{

  final String username;
  final Function(String)
  onNameChanged;

  const ProfilePage({
    super.key,
    required this.username,
    required this.onNameChanged,
  });

  void editName(
      BuildContext context
      ){

    TextEditingController name=
    TextEditingController(
      text:username,
    );

    showDialog(
      context:context,
      builder:(context){
        return AlertDialog(
          title:
          const Text(
            "Ganti Nama",
          ),
          content:
          TextField(
            controller:name,
          ),
          actions:[
            TextButton(
              onPressed:(){
                Navigator.pop(context);
              },
              child:
              const Text("Batal"),
            ),
            ElevatedButton(
              onPressed:(){
                if(
                name.text.isNotEmpty
                ){
                  onNameChanged(
                    name.text,
                  );
                }
                Navigator.pop(context);
              },
              child:
              const Text(
                "Simpan",
              ),
            )
          ],
        );
      },
    );
  }

  void logout(
      BuildContext context
      ){

    showDialog(
      context:context,
      builder:(context){
        return AlertDialog(
          title: const Text(
            "Logout",
          ),
          content:
          const Text(
            "Yakin logout?",
          ),
          actions:[
            TextButton(
              onPressed:(){
                Navigator.pop(context);
              },
              child:
              const Text("Batal"),
            ),
            ElevatedButton(
              onPressed:(){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder:(_)=>
                    const LoginPage(),
                  ),
                      (route)=>false,
                );
              },
              child:
              const Text(
                "Logout",
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(
      BuildContext context
      ){

    return Scaffold(
      appBar:AppBar(
        title:
        const Text(
          "Profile",
        ),
      ),
      body:Center(
        child:Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children:[
            const CircleAvatar(
              radius:60,
              child:
              Icon(
                Icons.person,
                size:70,
              ),
            ),
            const SizedBox(height:25),
            Text(
              username,
              style:
              const TextStyle(
                fontSize:26,
                fontWeight:
                FontWeight.bold,
              ),
            ),
            const SizedBox(height:40),
            SizedBox(
              width: 250,
              child: ElevatedButton.icon(
                onPressed:(){
                  editName(context);
                },
                icon:
                const Icon(
                  Icons.edit,
                ),
                label:
                const Text(
                  "Ganti Nama",
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            const SizedBox(height:15),
            SizedBox(
              width: 250,
              child: ElevatedButton.icon(
                onPressed:(){
                  logout(context);
                },
                icon:
                const Icon(
                  Icons.logout,
                ),
                label:
                const Text(
                  "Logout",
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//////////// FORGOT PASSWORD ////////////

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState()
  => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
extends State<ForgotPasswordPage>{

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool loading = false;

  void sendReset() async {

    if(!_formKey.currentState!.validate()){
      return;
    }

    setState(() {
      loading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      loading = false;
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Berhasil"),
          content: const Text(
            "Link reset telah dikirim ke email Anda",
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lupa Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_reset,
                size: 90,
                color: Colors.indigo,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Masukkan Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email wajib diisi";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Format email salah";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading ? null : sendReset,
                  child: loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Kirim Link Reset"),
                ),
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text("Kembali ke Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}