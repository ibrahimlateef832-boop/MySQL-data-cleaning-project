-- Data cleaning

select *
from layoffs;

select *
from layoffs_staging;

select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, 'date') as row_num
from layoffs_staging;

with duplicate_cte as
(
select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;


select *
from layoffs_staging
where company = 'Casper';


with duplicate_cte as
(
select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
delete
from duplicate_cte
where row_num > 1;

select *
from layoffs_staging2
where row_num > 1;


delete 
from layoffs_staging2
where row_num > 1;


select *
from layoffs_staging2;

-- Standardizing Data

select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);


select distinct industry
from layoffs_staging2
;

update layoffs_staging2
set  industry = 'crypto'
where industry like 'crypto%';

select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;


update layoffs_staging2
set country = trim(trailing '.' from country) 
where country like 'United State%';


select `date`
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` DATE;

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

update layoffs_staging2
set  industry = null
where industry = '';

select *
from layoffs_staging2
where industry is null
or industry = '';

select *
from layoffs_staging2
where company  like 'Bally%';

select t1.industry, t1.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
     on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;   


update layoffs_staging2 t1
join layoffs_staging2 t2
     on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null; 
     
select *
from layoffs_staging2;


select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num