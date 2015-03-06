package pt.ist.parkingInfo;

import java.io.IOException;
import java.util.Properties;

public class Config {

	public static final String CAR_PARK_INFO_GET_URL;

	static {
		final Properties properties = new Properties();
		try {
			properties.load(Config.class.getResourceAsStream("/configuration.properties"));
			CAR_PARK_INFO_GET_URL = properties.getProperty("car.park.info.get.url");
		} catch (final IOException e) {
			throw new Error(e);
		}
	}

}
