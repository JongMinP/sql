show tables;
desc pet;

select name,
		owner,
        species, 
        date_format(birth,'%Y-%m-%d') 
        from pet;
        
insert
	into pet
values( '장군이','안대혁','개','M','2010-05-10',null);

select * from pet;