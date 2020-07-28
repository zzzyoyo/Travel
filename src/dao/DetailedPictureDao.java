package dao;

import domain.DetailedPicture;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

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
    }

    public boolean savePicture(DetailedPicture detailedPicture){
        String sql = "INSERT INTO travelimage (Title, Description, Content, CityCode, UID, Path, Country_RegionCodeISO)" +
                " VALUES(?, ?, ?, ?, ?, ?, ?)";
         return update(sql,detailedPicture.getTitle(),detailedPicture.getDescription(),detailedPicture.getTheme(),
                detailedPicture.getCityId(), detailedPicture.getUid(),detailedPicture.getPath(),detailedPicture.getCountryISO());
    }

    public boolean setPicture(DetailedPicture detailedPicture){
        String sql = "UPDATE travelimage SET Title=?,Description= ? , Content = ?, Country_RegionCodeISO = ?, " +
                "CityCode = ?, PATH = ?, RecentUpdate = ? WHERE ImageID = ?";
//        System.out.println(new Date());
//        System.out.println(new Timestamp(new Date().getTime()));
        return update(sql,detailedPicture.getTitle(),detailedPicture.getDescription(),detailedPicture.getTheme(),
                detailedPicture.getCountryISO(),detailedPicture.getCityId(),detailedPicture.getPath(),new Timestamp(new Date().getTime()),detailedPicture.getId());
    }

    /**
     * 返回的信息包括id, title, author, path, theme, updateTime
     * @param number
     * @param sort
     * @return
     */
    public List<DetailedPicture> getSortedDetailedPictures(int number,String sort){
        String sql = "SELECT i.ImageID id, i.Title title, i.PATH path, u.UserName author, i.Content theme, i.RecentUpdate " +
                "recentUpdate FROM travelimage i, traveluser u WHERE i.UID = u.UID ORDER BY "+ sort+" DESC LIMIT 0,?";
        return getAll(sql,number);
    }
}
