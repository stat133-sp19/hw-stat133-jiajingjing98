Data Dictionary
================
Jingjing Jia
3/3/2019

This is a data dictionary including descriptions of all variable names of shot data.

-   **team\_name**: character, name of team the player is belong to

-   **game\_date**: character, the date when the game happened

-   **season**: integer, indicates during which season the game took place

-   **period**: integer, an NBA game is divided in 4 periods of 12 mins each. For example, a value for period = 1 refers to the first period (the first 12 mins of the game).

-   **minutes\_remaining**: integer, the amount of time in minutes that remained to be played in a given period.

-   **seconds\_remaining**: integer, the amount of time in seconds that remained to be played in a given period.

-   **shot\_made\_flag**: character, indicates whether a shot was made (y) or missed (n)

-   **action\_type**: character, involves the basketball moves used by players, either to pass by defenders to gain access to the basket, or to get a clean pass to a teammate to score a two pointer or three pointer.

-   **shot\_type**: character, indicates whether a shot is a 2-point field goal, or a 3-point field goal

-   **shot\_distance**: integer, distance to the basket (measured in feet)

-   **opponent**: character, name of the opponent team in a game

-   **x**: integer, the x-coordinate (measured in inches) of the court where a shot occurred

-   **y**: integer, the y-coordinate (measured in inches) of the court where a shot occurred
