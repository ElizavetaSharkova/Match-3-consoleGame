# Match-3-consoleGame
Console prototype game match 3. language: lua

You can open Start.lua by lua interpreter for run this project

Example of input:
1) q - to exit the game
2) m 3 0 r - element from 3 column and 0 row is moves to the right (l - left, r - right, u - up, d - down)

Example of output:
  | 0 1 2 3 4 5 6 7 8 9
 --------------------
0 | A B C D E F A B C D
1 | В A B C D E F A B C
2 | A B C D E F A B C D
3 | В A B C D E F A B C
4 | A B C D E F A B C D
5 | В A B C D E F A B C
6 | A B C D E F A B C D
7 | В A B C D E F A B C
8 | A B C D E F A B C D
9 | В A B C D E F A B C

Poin: 0

Description:
1. If there are 3 or more identical elements in one row or column, they are deleted. Elements above the removed are shifted down. Points are awarded for this.
2. If the elements match at the beginning of the game, the player is lucky. Points are awarded also.
3. If the user made a mistake with the input, the points are reduced and a message is displayed.
4. If there are no possible combinations, the user is not lucky. Elements are mixed and points are reduced also.
