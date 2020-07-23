package dao;

import domain.DetailedPicture;

public class DetailedPictureDao extends Dao<DetailedPicture> {
    public DetailedPicture getDetailedPictureByID(int id){
        String sql = "SELECT image.ImageID id, image.PATH path, image.Title title, u.UserName author, " +
                "image.Description description, image.Content theme, image.RecentUpdate updateTime, image.Hot hot, " +
                "cities.AsciiName city, countries.Country_RegionName country " +
                "FROM travelimage image, geocities cities, geocountries_regions countries, traveluser u " +
                "WHERE image.ImageID = ? AND cities.GeoNameID = image.CityCode AND " +
                "image.Country_RegionCodeISO = countries.ISO AND image.UID = u.UID";
        return get(sql,id);
    }

    public boolean savePicture(DetailedPicture detailedPicture){
        String sql = "INSERT INTO travelimage (Title, Description, Content, CityCode, UID, Path, Country_RegionCodeISO)" +
                " VALUES(?, ?, ?, ?, ?, ?, ?)";
         return update(sql,detailedPicture.getTitle(),detailedPicture.getDescription(),detailedPicture.getTheme(),
                detailedPicture.getCityId(), detailedPicture.getUid(),detailedPicture.getPath(),detailedPicture.getCountryISO());
    }
}
