import "package:collection/collection.dart";


main(){
  
 var questions = [
   { "page": 1 , "type" : "subheading", "name" : "page 1"},
   {"page": 1, "type" : "text"},
   { "page": 1, "type" : "text"},
   {"page": 1, "type" : "text"},
   {"page": 2,"type" : "subheading" ,"name" : "page 2"},
   {"page": 2,"type" : "text"},
   {"page": 2,"type" : "text"},
   {"page": 2,"type" : "text"},
  {"page": 3,  "type" : "subheading", "name" : "page 3"},
   {"page": 3, "type" : "text"},
   {"page": 3, "type" : "text"},
   {"page": 3, "type" : "text"},
 ];
  
  var pages = [];  
  
  var temp = [];
  questions.forEach((element) {
        if(element['type'] == 'subheading'){
      // print(element);
      if(temp.length > 0){
        pages.add(temp);
        
        temp.clear();

      }else{
            temp.add(element);
      }
    }else{
          temp.add(element);

    }
  }

  
);
print(pages);       



  var pages1 = groupBy(questions, (Map obj) => obj['page']);


  print(pages1);
}