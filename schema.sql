-- scheam changes

CREATE TABLE corporate_presence ( total int, company text, city text, country text);


insert into corporate_presence
select count(*), company, city, country from jobs join address_info on lat=latitude and long = longitude 
where latitude !=0 and latitude != ' ' and latitude is not null
group by company, city, country 
order by count(*) desc;

CREATE INDEX corporate_presence_idx_1 on corporate_presence(country);
CREATE INDEX corporate_presence_idx_2 on corporate_presence(city);
CREATE INDEX corporate_presence_idx_3 on corporate_presence(company);


CREATE TABLE country_points (lat int, long int, country text, company text);
insert into country_points select distinct latitude, longitude, country, company from jobs join address_info on lat=latitude and long=longitude;

-- query2

create table companyGrowth 
(total int, company text, countr text, postedYear int);

insert into companyGrowth 
select count(*), company, country, strftime('%Y', firstSeenDate) as postedYear from jobs join address_info on lat = latitude and long  = longitude
group by company, country, postedYear order by postedYear, country;


--select company, count(*) as totalJobs, posteddate  
--from jobs where company = 'Adecco'
--group by posteddate;
