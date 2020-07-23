package dao;

import domain.GeoInformation;

import java.util.List;

public class GeoDao extends Dao<GeoInformation> {
    public List<GeoInformation> getAllCountries(){
        String sql = "SELECT ISO id, Country_RegionName name FROM geocountries_regions; ";
        return getAll(sql);
    }

    public List<GeoInformation> getCitiesByCountryID(String countryID){
        String sql = "SELECT GeoNameID id, AsciiName name FROM geocities WHERE Country_RegionCodeISO = ? ; ";
        return getAll(sql,countryID);
    }
}
