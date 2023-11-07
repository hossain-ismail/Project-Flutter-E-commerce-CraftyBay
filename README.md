# module_21_class_1_e_commerce

For internet connection check- install package connectivity_plus ,
first get initial internet status when app is open then start listen the internet check status and take action according to both initail and then listen value of internet status. wehn internet is okey then ther is no toast/snackbar message if internet disconnected then show a snackbar message.


#### OutPut
Inetrnet Connection Check

![Screenshot_20231018_181436](https://github.com/hossain-eee/Ecommerce-Ostad/assets/101991583/fbc08b2d-ff1f-4403-9959-a6da97014a32)

https://drive.google.com/file/d/1TYEYhAxVQAYe5BM7goZncrLfYF9VosGM/view?usp=sharing

complete profile

![complete profile](https://github.com/hossain-eee/Ecommerce-Ostad/assets/101991583/db7eeb6d-ae55-441c-9765-34523f20044f)

![complete profile console](https://github.com/hossain-eee/Ecommerce-Ostad/assets/101991583/3405542f-25ac-492a-ad98-2bba1727ad3d)



### E-Commerce project structure 
Here used Layer architecture, here we divided layer into two part
-application --hold the file which broadcast information all over tha app like configuration, its an entry point of our app
-data -- hold data related operation like network. We will get data/information from this data(it would have file), we don't know where from coming information/data it will manage the file which is situated inside data folder. so in future if client want to change data/information source like firebase to database or database to firebase, we don't have any problem just change code inside the data folder then it will apply every where. If you don't use this operate file (inside data folder)  and code direct insdie app other file then every where need to change according to client demand which would so painful 
-presentation -- hold user's all visible things
-stat_holders-- getx all controller
-utility--color,style

.
└── app layer structure
├── lib/
│   ├── application
│   ├── data  
│   └── presentation/
│       ├── state_holders
│       └── ui/
│           ├── screens
│           ├── utlity
│           └── widgets
└── main.dart

app layer structure
└── lib/
    ├── application
    ├── data  
    └── presentation/
        ├── state_holders
            └── ui/
                ├── screens
                ├── utlity
                └── widgets
