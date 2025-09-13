%Movie Facts: movie (Movie Name, Genre, Rating)
movie(inception, sci_fi, high).
movie(the_dark_knight, action, high).
movie(interatellar, sci_fi, high).
movie(toy_story, animation, medium).
movie(finding_nemo, animation, medium).
movie(avatar, sci_fi, high).
movie(john_wick, action, high).
movie(frozen, animation, high).
movie(the_lion_king, animation, high).
movie(the_matrix, sci_fi, high).


%Recommend movies based on genre and high rating
recommend(Movie, Genre) :-
	movie(Movie, Genre, high).


%Recommend movies if they belong to either sci-fi or action genres
recommend_popular(Movie) :- 
	movie(Movie, Genre, high),
	(Genre = sci_fi; Genre = action).

ask_user_recommendation :-
	write('Enter Your preferred genre (sci_fi, action, animation): '),
	read(Genre),
	recommend(Movie, Genre),
	write('You might like: '), write(Movie), nl,
	fail.

