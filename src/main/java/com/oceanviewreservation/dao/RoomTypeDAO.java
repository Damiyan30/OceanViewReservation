package com.oceanviewreservation.dao;

import com.oceanviewreservation.db.Db;
import com.oceanviewreservation.model.RoomType;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomTypeDAO {

    public List<RoomType> findAll() throws Exception {
        List<RoomType> list = new ArrayList<>();
        String sql = "SELECT type_id, type_name, nightly_rate FROM room_types ORDER BY type_name";

        try (Connection con = Db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                RoomType rt = new RoomType();
                rt.typeId = rs.getInt("type_id");
                rt.typeName = rs.getString("type_name");
                rt.nightlyRate = rs.getDouble("nightly_rate");
                list.add(rt);
            }
        }
        return list;
    }
}