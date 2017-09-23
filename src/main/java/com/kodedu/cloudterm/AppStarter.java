package com.kodedu.cloudterm;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@SpringBootApplication
public class AppStarter {

    public static void main(String[] args) throws IOException {
//        String tmpDir = System.getProperty("java.io.tmpdir");
//        Path prefsPath = Files.createTempDirectory(Paths.get(tmpDir), "prefs");
//        Files.createDirectories(prefsPath);
//        System.setProperty("java.util.prefs.userRoot", prefsPath.toString());

        SpringApplication.run(AppStarter.class, args);
    }
}
