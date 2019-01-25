pragma solidity^0.4.25;
contract HelloWorld{
    //第一題
    function sayHello() public returns (string) {
        return ("Hello World");
    }
    
    //第二題
    struct Student{
        string name;
        string PorF;
        uint scores; 
        address addr;
    }
    mapping (address => Student) public students;
    
    function enter_scores(string _name,uint _scores) public returns (string,uint,string,address) {
        string memory tmp=(_scores >= 60)?"及格":"不及格";
            
        students[msg.sender] =  Student({
            name: _name,
            scores: _scores,
            addr: msg.sender,
            PorF: tmp
        });
        return (_name,_scores,"已登入成績",msg.sender);
    }
    
    function lookup_scores(address _addr) public returns (string,uint,string) {
        Student s = students[_addr];
        return (s.name,s.scores,s.PorF);
    }
    
    function delete_student() public returns (string) {
        delete students[msg.sender];
        return ("已清除成功");
    }
}

