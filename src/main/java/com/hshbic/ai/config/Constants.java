package com.hshbic.ai.config;

/**
 * Application constants.
 */
public final class Constants {

    // Regex for acceptable logins
    public static final String LOGIN_REGEX = "^[_.@A-Za-z0-9-]*$";

    public static final String SYSTEM_ACCOUNT = "system";
    public static final String ANONYMOUS_USER = "anonymoususer";
    public static final String DEFAULT_LANGUAGE = "en";
    public static final String MUSIC_DOMAIN_URL = "http://120.27.157.19/ai-music-repo";
    public static final String MUSIC_LIST_PAGESIZE = "10";
    private Constants() {
    }
}
