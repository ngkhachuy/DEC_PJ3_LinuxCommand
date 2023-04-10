#!/bin/sh

# Book The Adventures of Tom Sawyer

echo '+------------------------------+'
echo '| THE ADVENTURES OF TOM SAWYER |'
echo '+------------------------------+'

# 1. How many chapters has the book?
count_chapters=$(grep '^CHAPTER' 74-0.txt | grep -cv '\.')
echo '1. There is' $count_chapters 'chapters in the book.'

# 2. Count the number of empty lines
count_empty_lines=$(grep -c '^\s*$' 74-0.txt)
echo '2. There is' $count_empty_lines 'empty lines.'

# 3. How often does the names "Tom" and "Huck" appears in the book?
count_Tom=$(grep -co 'Tom' 74-0.txt)
count_Huck=$(grep -co 'Huck' 74-0.txt)
echo '3. The name "Tom" appears' $count_Tom 'times in the book.'
echo '   The name "Huck" appears' $count_Huck 'times in the book.'

# 4. How often do they appear together in one line?
count_tom_huck=$(grep 'Tom' 74-0.txt | grep -cw 'Huck')
echo '4. The name "Tom" and "Huck" appears together in one line' $count_tom_huck 'times in the book.'

# 5. Go to line 1234 of the file. What is the third word?
return_char=$(sed -n '1234p' 74-0.txt | cut -f 3 -d ' ')
echo '5. The third word of line 1234 is ['$return_char']'

# 6. Count the words and lines in the book
count_words=$(wc -w 74-0.txt | cut -f 1 -d ' ')
count_line=$(wc -l 74-0.txt | cut -f 1 -d ' ')
echo '6. The book has' $count_line 'lines and' $count_words 'words.'

# 7. Translate all words of the book into lowercase
# 8. Count, how often each word in this book appears
# 9. Order the result, starting with the word with the highest frequency. Which word is it?
# 10. Write all the above steps (7,8,9) in one statement (using pipes)
most_frequency_word=$(cat 74-0.txt | tr \[:lower:] \[:upper:] | tr \[:space:] \\n | sed '/^$/d' | sort | uniq -c | sort -gr | head -1 | grep -oE '[^ ]+$')
echo '* The most frequency word is ['$most_frequency_word']'

# 11. Compare the 20 most frequent words of each book. How many are in common?
echo '* The 20 most frequent words of the book [The Adventures of Tom Sawyer]'
top20_book_1=$(cat 74-0.txt | tr \[:lower:] \[:upper:] | tr \[:space:] \\n | sed '/^$/d' | sort | uniq -c | sort -gr | head -20 | grep -oE '[^ ]+$' > top20_book1)
cat -n top20_book1

echo '* The 20 most frequent words of the book [Moby-Dick; or, The Whale]'
top20_book_2=$(cat 2701-0.txt | tr \[:lower:] \[:upper:] | tr \[:space:] \\n | sed '/^$/d' | sort | uniq -c | sort -gr | head -20 | grep -oE '[^ ]+$' > top20_book2)
cat -n top20_book2

cat top20_book1 top20_book2 | sort | uniq -d > common_words
echo '* There is' $(wc -l common_words | cut -f 1 -d ' ') 'words are common.'
cat -n common_words

##################
echo 

echo '+----------+'
echo '| city.csv |'
echo '+----------+'

# 1. Create a working copy of your file city.csv
cat city.csv > city_BK.csv
echo '- Created file [city_BK.csv] as a copy of [city.csv]'

# 2. Exchange in the file all occurences of the Province "Amazonas" in Peru (Code PE) with "Province of Amazonas"
sed -ie 's/PE,Amazonas/PE,"Province of Amazonas"/' city_BK.csv
echo '- All Province "Amazonas" in Peru have been change to "Province of Amazonas" (in file city_BK.csv)'

# 3. Print all cities which have no population given
awk 'BEGIN { FS=","; OFS=","} {if ($4="NULL") print $1, $2, $3;}' city_BK.csv > city_have_null_population
count_city_have_no_population=$(wc -l city_have_null_population)
echo '- There is' $count_city_have_no_population 'cities have no population given (details in file city_have_null_population).'
#cat city_have_null_population

# 4. Print the line numbers of the cities in Great Britain (Code: GB)
grep -n GB city_BK.csv > Great_Britain
count_GB=$(wc -l Great_Britain | cut -f 1 -d ' ')
echo '- There is' $count_GB ' cities in Great Britain.'
cat Great_Britain | tr \: \\t 

# 5. Delete the records 5-12 and 31-34 from city.csv and store the result in city.2.csv
sed -e '5,12d;31,34d' city_BK.csv > 'city.2.csv'
echo '- New file [city.2.csv] has been created by deleted line 5-12 and 31-34 of file [city.csv].'

# 6. Combine the used commands from the last two tasks and write a bash-script (sequence of commands), which delete all british cities from the file city.csv
sed -e '/GB/d' city_BK.csv > city_without_GreatBritain
echo '- All British cities from city.csv have been deleted and save new file as [city_without_GreatBritain]'
