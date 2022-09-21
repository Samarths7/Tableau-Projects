/* 
Extracting the total number of COVID-19 cases and deaths around the world till date.Calculating the deaths as a percentage pf the total number of cases.
*/
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From C19Dashboard.dbo.CovidDeaths$
where continent is not null
--To exclude cases where continent is listed as null
order by 1,2

/* 
Determining total number of deaths by continent and putting the data in descending order.
*/
SELECT location,SUM(cast(new_deaths as int)) as TotalDeathCount
From C19Dashboard.dbo.CovidDeaths$
where continent is null
and location not in ('World', 'European Union', 'International')
--European Union is a part of Europe
Group by location
order by TotalDeathCount desc

/*
Extracting the population and infection count of each country. Calculating the percentage of the country's population infected by COVID-19.
*/
SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From C19Dashboard.dbo.CovidDeaths$
Group by location,population
order by PercentPopulationInfected desc

/* 
Determining the cumulative infection count of every country on a daily basis then calculating the percentage of the population infected as of that day.
*/
SELECT location, population, date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From C19Dashboard.dbo.CovidDeaths$
Group by Location, Population, date
order by PercentPopulationInfected desc
