package dao;

import domain.DetailedPicture;

public class DetailedPictureDao extends Dao<DetailedPicture> {
    public DetailedPicture getDetailedPictureByID(int id){
        String sql = "SELECT image.ImageID id, image.PATH path, image.Title title, u.UserName author, " +
                "image.Description description, image.Content theme, image.RecentUpdate updateTime, image.Hot hot, " +
                "cities.AsciiName city, countries.Country_RegionName country, " +
                "image.CityCode cityId, image.Country_RegionCodeISO countryISO " +
                "FROM travelimage image, geocities cities, geocountries_regions countries, traveluser u " +
                "WHERE image.ImageID = ? AND cities.GeoNameID = image.CityCode AND " +
                "image.Country_RegionCodeISO = countries.ISO AND image.UID = u.UID";
        return get(sql,id);
        /*
        "SELECT image.ImageID id, image.PATH path, image.Title title, u.UserName author, " +
                "image.Description description, image.Content theme, image.RecentUpdate updateTime, image.Hot hot, " +
                "cities.AsciiName city, countries.Country_RegionName country, " +
                "image.CityCode cityId, image.Country_RegionCodeISO countryISO" +
                "FROM travelimage image, geocities cities, geocountries_regions countries, traveluser u " +
                "WHERE image.ImageID = ? AND cities.GeoNameID = image.CityCode AND " +
                "image.Country_RegionCodeISO = countries.ISO AND image.UID = u.UID";
        为什么不行？？？！
        "SELECT image.ImageID id, image.PATH path, image.Title title, u.UserName author, " +
                "image.Description description, image.Content theme, image.RecentUpdate updateTime, image.Hot hot, " +
                "image.CityCode cityId, image.Country_RegionCodeISO countryISO, " +
                "cities.AsciiName city, countries.Country_RegionName country " +
                "FROM travelimage image, geocities cities, geocountries_regions countries, traveluser u " +
                "WHERE image.ImageID = ? AND cities.GeoNameID = image.CityCode AND " +
                "image.Country_RegionCodeISO = countries.ISO AND image.UID = u.UID";
         */
    }

    public boolean savePicture(DetailedPicture detailedPicture){
        String sql = "INSERT INTO travelimage (Title, Description, Content, CityCode, UID, Path, Country_RegionCodeISO)" +
                " VALUES(?, ?, ?, ?, ?, ?, ?)";
         return update(sql,detailedPicture.getTitle(),detailedPicture.getDescription(),detailedPicture.getTheme(),
                detailedPicture.getCityId(), detailedPicture.getUid(),detailedPicture.getPath(),detailedPicture.getCountryISO());
    }

    public boolean setPicture(DetailedPicture detailedPicture){
        String sql = "UPDATE travelimage SET Title=?,Description= ? , Content = ?, Country_RegionCodeISO = ?, " +
                "CityCode = ? WHERE ImageID = ?";
        return update(sql,detailedPicture.getTitle(),detailedPicture.getDescription(),detailedPicture.getTheme(),
                detailedPicture.getCountryISO(),detailedPicture.getCityId(),detailedPicture.getId());
    }
}
