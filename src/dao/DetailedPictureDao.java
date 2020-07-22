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
        DetailedPicture detailedPicture = get(sql,id);
        return detailedPicture;
    }
}
