![alt text](https://s.gr-assets.com/assets/icons/goodreads_icon_100x100-4a7d81b31d932cfc0be621ee15a14e70.png)
# Rate a Read with goodreads

[Goodreads](https://www.goodreads.com) is a social cataloging website for people who love **Books**.Users can just sign up and then create a reading list or update the books they have read or currently reading or even write a review. They can also form their own groups of book suggestions, surveys, polls, blogs, and discussions.
<br><br> 
In this project, I will explore the different features extracted from Books and Authors to determine what makes a book popular or what are the determinants in a book which earns a good rating?
### Who can use this?
This project is a tool to any prospective writer who is planning to write a book.
<br>
Well, they say:
>*If you want to be a writer, you must do two things above all others: read a lot and write a lot* 

Sure!
<br>But in this age of Data, some science and some analysis can work as a magic!
### Where the Data comes from?
I am grabbing all the Book Details on Science Fiction and the corresponding Author Details using an API.  
<br>
The first version of this tool is to search and explore the **"Science Fiction/Fantasy"** Genre. In the later versions, I intend to work on the genre as an input parameter and thus this tool will work for any genre or search keyword.
<br><br>
Now, let's divide the whole project in a few steps:
1. [Data Extraction and Load Database](https://github.com/Oindrila-Sen/Springboard/blob/master/Capstone1/goodreads/GoodReads_Data_Extraction_Load_Database.ipynb)
2. [Data Wrangling and Features Extraction](https://github.com/Oindrila-Sen/Springboard/blob/master/Capstone1/goodreads/GoodReads_Data_Wrangling.ipynb)
3. [Exploratory Data Analysis](https://github.com/Oindrila-Sen/Springboard/blob/master/Capstone1/goodreads/GoodReads_EDA.ipynb)
4. [Fit a Model to predict Average Rating of a book](https://github.com/Oindrila-Sen/Springboard/blob/master/Capstone1/goodreads/Goodreads_Fit_a_Model.ipynb)

<br>
The **Random Forest** Model And **SVR** Model are 95% accurate! Well, that's a good start.
