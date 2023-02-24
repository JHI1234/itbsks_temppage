function writeSave(){
   if(!document.insertform.writer.value){
     alert("작성자를 입력하십시오.");
     document.insertform.writer.focus();
     return false;
   }
   
   if(!document.insertform.subject.value){
     alert("제목을 입력하십시오.");
     document.insertform.subject.focus();
     return false;
   }
   
   if(!document.insertform.content.value){
     alert("내용을 입력하십시오.");
     document.insertform.content.focus();
     return false;
   }
        
   if(!document.insertform.passwd.value){
     alert("비밀번호를 입력하십시오.");
     document.insertform.pasqna_formswd.focus();
     return false;
   }
 }
