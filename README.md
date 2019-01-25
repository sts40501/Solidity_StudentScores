# AWIN Lab 新生作業 (區塊鏈)

本作業透過 [Remix Solidity IDE](https://remix.ethereum.org) 開發與展示，
利用 Solidity 達成一套成績記錄系統，將成績紀錄在智能合約當中。

## 步驟流程
### 登入成績 
![enter image description here](https://i.imgur.com/Kl9Votn.png)

### 查詢成績
![enter image description here](https://i.imgur.com/OFAvZto.png)
### 清除記錄
![enter image description here](https://i.imgur.com/MfzSaMw.png)

## Solidity 程式說明
    struct Student{
        string name;
        string PorF;
        uint scores; 
        address addr;
    }
> 宣告`Student`變數為結構資料型態，
> 當中包含`name`（學生姓名）、`PorF`（是否通過）兩個字串、
> `scores`（考試成績）無符整數與`addr`（帳戶位址）位址。

結構資料型態在 Solidity 裡可以當作宣告一物件，當中變數的命名，
同樣也須把資料型態放在前面，接著再命名變數名稱。
## 

    mapping (address => Student) public students;
    
    function enter_scores(string _name,uint _scores) public{
        string memory tmp=(_scores >= 60)?"Pass":"Fail";
        
        students[msg.sender] =  Student({
            name: _name,
            scores: _scores,
            addr: msg.sender,
            PorF: tmp
        });
    }

> 在`enter_scores()`函數輸入`name`、`scores`兩參數，
> 並將輸入的參數記錄在合約裡 。

執行`enter_scores()`函數時，`msg.sender`也就是執行函數的位址，
會放在映射中鍵的位置，輸入的參數則放進在映射中值的`Student`結構。
##

    function lookup_scores(address _addr) public returns (string,uint,string) {
        Student s = students[_addr];
        return (s.name,s.scores,s.PorF);
    }

> 輸入帳戶位址後回傳對應的學生姓名、考試成績與是否及格。

##


    function delete_student() public{
        delete students[msg.sender];
    }

>刪除記錄在合約當中的位址與學生的資料。

`delete`會將所有變數的數值初始化，
因此在這邊`delete students[msg.sender]`，
`students[msg.sender]`的`msg.sender`會予以保留，
且值當中的`Student`資料結構也會保留，不過結構的內部數值會被初始化。


## 開發前的準備
開發一個軟體或是網站在上架或公開服務之前，
開發者都會先在自己的電腦上（本機）或利用區域網路來測試程式執行的結果，
等到測試完成後，才會部署到公開提供服務。 

而在開發區塊鏈的智能合約過程也是如此，
況且公開鏈上所有讀寫與計算等操作都需要付出代價，
因此將使用 [ganache-cli](https://gasolin.gitbooks.io) 這套工具，
在電腦上模擬智能合約所需的ㄧ以太坊區塊鏈測試環境。

首先，在電腦上安裝 [Node.js](https://nodejs.org/) 之後，開啟終端機鍵入：

    $ (sudo) npm install -g truffle ganache-cli

待安裝完畢後，輸入`ganache-cli`開始執行：
![enter image description here](https://i.imgur.com/itblQOS.png)

> `ganache-cli`自動建立了10個帳戶與對應的私鑰，
> 每個帳戶中都有100個測試用的以太幣。

## 開發過程

Solidity 程式以下透過 [Remix Solidity IDE](https://remix.ethereum.org) 作展示：

![工作環境](https://i.imgur.com/NTW4qlg.png "Remix")

> IDE 主畫面
##
由於 Solidity 是個很新的語言，不同版本之間的語法差異很大，
在此我們選擇使用 0.4.25 版本作為後續開發的版本。

![enter image description here](https://i.imgur.com/RGNaABR.png)

> 在`Compile`分頁裡可以選擇 Solidity 版本

![enter image description here](https://i.imgur.com/xnGUh1S.png)

> 選擇`0.4.25+commit.59dbf8f1`
##
選擇完版本我們就可以開始進行編譯了，按下`Strat to compile`進行編譯，
如果有發生例外或錯誤再針對程式碼進行修改。

![enter image description here](https://i.imgur.com/i4lTXuD.png)

> 編譯完成後，會在底下出現訊息方框，
> 若有錯誤會顯示紅色，藍紫色則為警告。
##
接著我們切換到`Run`分頁，
在`Environment`當中選擇`Web3 Provider`環境選用本機的私網路，
並在`Account`選擇要用來測試的帳戶（即是我們用來辨識學生的帳戶位址）。

![enter image description here](https://i.imgur.com/b6W1Oot.png)

> 在`Environment`中也可以選用`Injected Web3`環境透過如 [MetaMask](https://metamask.io/) 的服務
> 或是選用`JavaScript VM` 環境將資料只存在記憶體中。
##
按下後`Web3 Provider`會跳出彈跳視窗，這裡可以指定伺服器的位置。

![enter image description here](https://raw.githubusercontent.com/alincode/30-days-smart-contract/master/assets/09/web3_provider.png)

> 網址輸入剛剛於`ganache-cli`下方出現的`127.0.0.1:8545`。
##

接下來按下`Deploy`按鈕開始發佈，就會建立一個智能合約的實例。

![enter image description here](https://i.imgur.com/MCIBRJb.png)

> 在此我們選擇`HelloWorld`作為我們要發佈的合約。
##
接著就可以使用出現在下方的`Deployed Contracts`來呼叫智能合約的函數了。

![enter image description here](https://i.imgur.com/Voenebb.png)

> 程式碼當中有四個函數與一個結構。

## 開發結果
### 第一題
![enter image description here](https://i.imgur.com/u3sBCkS.png)

> 當按下`sayHello()`函數按鈕時，output會回傳`Hello World`字串。

### 第二題
設計一套成績紀錄系統，功能包括：登入成績（某某某，幾分）、
查詢成績（某某某 => 幾分）並判斷成績是否及格
（大於等於60及格，小於60分不及格），格式不拘，只要能達成上述要求即可。
#### 登入成績
在`enter_scores()`函數中輸入`_name`為`Lion`、`_scores`為`100`的參數。

![enter image description here](https://i.imgur.com/ryKHWuE.png)

> 帳戶位址：`0xca35b7d915458ef540ade6068dfe2f44e8fa733c`
> 學生姓名：Lion
> 考試成績：100

直接於`Account`當中切換為其他帳戶。
在`enter_scores()`函數中輸入`_name`為`Peter`、`_scores`為`49`的參數。

![enter image description here](https://i.imgur.com/2Je2tkv.png)

> 帳戶位址：`0x14723a09acff6d2a60dcdf7aa4aff308fddc160c`
> 學生姓名：Peter
> 考試成績：49

#### 查詢成績
在`_addr`當中輸入帳戶位址`0xca35b7d915458ef540ade6068dfe2f44e8fa733c`：

![enter image description here](https://i.imgur.com/enWKJyi.png)
> 學生姓名：Lion
> 考試成績：100
> 是否及格：及格

在`_addr`當中輸入帳戶位址`0x14723a09acff6d2a60dcdf7aa4aff308fddc160c`：

![enter image description here](https://i.imgur.com/lFtdTRz.png)
> 學生姓名：Peter
> 考試成績：49
> 是否通過：不及格

#### 清除記錄
![enter image description here](https://i.imgur.com/FutUTY8.png)

> 可透過`delete_student()`函數清除學生資料。


## 遇到的困難

因為之前對區塊鏈的概念並沒有很深入的了解，
很高興能夠實作這次的新生作業，不管是對區塊鏈、以太坊、智能合約、 
Solidity 程式碼與開發環境，甚至是對於如何撰寫說明文件都有相當大的幫助，
收穫甚多，再次萬分感謝。

在寫 Solidity 程式碼時一開始照著說明文件編寫並無太大問題，
但接著就開始了解到由於 Solidity 這個程式語言還相當新，因此每次的改版，
如由0.3.x到0.4.x或是0.4.x到0.5.x版本，當中就有許多語法不盡相同。

如在學長所提供的範例文件的 ["為智能合約加入新功能"](https://gasolin.gitbooks.io/learn-ethereum-dapp/content/add-new-method-in-smart-contract.html) 當中的程式碼 ：

    function echo(string name) constant returns (string) {
        return name;
    }
 裡面的`constant`就已在0.5.0版本當中[停止使用](https://solidity.readthedocs.io/en/v0.5.0/050-breaking-changes.html#syntax)：
 
 ![enter image description here](https://i.imgur.com/PZOMykP.png)

除了在程式版本上的差異，還有整合開發環境上當更新了合約內容，
就需要先重新新編譯一次，再將編譯結果部署到本機上，
再透過`truffle console`執行查看結果：
```
$ truffle compile
...
$ truffle migrate --reset
...
$ truffle console
> let contract
> HelloWorld.deployed().then(instance => contract = instance)
```
因此每重新編譯、部署一次就要花費比較多的時間，
且需要在多個終端機視窗當中切換。

直到後來繼續上網找資料，最後找到了  [Remix Solidity IDE](https://remix.ethereum.org)，
不但解決了 Solidity 版本問題（只要點一下就能切換使用的版本），
而且大大加快了編譯、部署的時間（也是按一個按鈕就好），
更讓我對帳戶位址有了比較深入的概念，而不會迷失在終端機當中。

當然我相信 truffle 這套工具一定也是相當實用地，
不過在第一次接觸區塊鏈與智能合約， Remix 確實是比較好上手的一個工具。

而在 Solidity 程式碼當中，遇到比較大的問題是回傳結構裡的資料，
也是花了比較多時間找到[這篇文章](http://www.tryblockchain.org/Solidity-Struct-%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84.html)才解決的。
##
而在剛開始了解區塊鏈的概念時，除了看學長所提供的範例網站說明，
另外有在網路上找到此部視覺化區塊鏈的影片，也是非常受用：

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/_160oMzblY8/0.jpg)](https://youtu.be/_160oMzblY8)

在學習 Solidity 程式碼過程中，亦有找到透過製作個人化殭屍人物，
比較簡易入門的學習網站：
https://cryptozombies.io/zh


## 對於區塊鏈的看法

我認為區塊鏈不僅對於未來，就算是對目前的影響也是非常的大，
區塊鍊的特性"不可竄改、真實性、透明性、獨一性、集體共識"讓它成為最早且最主要用於加密的電子貨幣，但隨著越來越多人的開發並且開始擁有了以太坊的智能合約與Dapp，
不管是遊戲、募資，只要是需要公開，可被信任的紀錄時，都可以透過智能合約達成，
因此應用是相當廣泛的。

不過由於一但公開部署就無法被修改，要如何去做合約的升級或修正也是相當重要的問題。


## 參考資料
[1] https://gasolin.gitbooks.io/learn-ethereum-dapp/content/

[2] https://medium.com/@pomelyu5199/%E5%9C%A8%E5%8D%80%E5%A1%8A%E9%8F%88%E4%B8%8A%E5%AF%A6%E4%BD%9C-todo-app-%E4%B8%8A-truffle-3987f3a3be33

[3] https://truffleframework.com/docs/truffle/getting-started/using-truffle-develop-and-the-console

[4] https://medium.com/@gus_tavo_guim/using-truffle-to-create-and-deploy-smart-contracts-95d65df626a2

[5] https://ethereum.stackexchange.com/questions/62906/typeerror-data-location-must-be-memory-for-parameter-in-function-but-none-wa
[6] http://me.tryblockchain.org/solidity-struct.html

[7] https://ethereum.stackexchange.com/questions/25945/call-write-function-which-doesnt-change-contract-value

[8] https://ithelp.ithome.com.tw/articles/10201629?sc=iThelpR

[9] https://zhuanlan.zhihu.com/p/28266204

[10] https://ithelp.ithome.com.tw/articles/10201750

[11] https://ithelp.ithome.com.tw/articles/10205760?sc=iThelpR

[12] https://cryptozombies.io/zh

[13] https://eattheblocks.com/best-way-to-learn-solidity-for-beginners/

[14] https://www.jianshu.com/p/d8337ab12e5f

[15] https://ithelp.ithome.com.tw/articles/10207884?sc=iThelpR

[16] https://data-science-group.github.io/BigDataSociety/Hackathon/2018-09/Blockchain.pdf

[17] https://juejin.im/post/5b8e8d08f265da434a1fe491

[18] https://truffleframework.com/docs/truffle/reference/configuration

[19] http://truffle.tryblockchain.org/

[20] https://www.youtube.com/watch?v=epls0ToPedc

[21] https://ethfans.org/posts/510

[22] https://lilymoana.github.io/ethereum_theory.html

[23] https://www.ethereum.org/cli

