package main

import (
	"flag"
	"log"
)

// DBConfig wraps up all of the DB configuration
type DBConfig struct {
	Host string
	Port int
	User string
	Pass string
	Name string
}

// ServiceConfig defines all of the JRML pool configuration parameters
type ServiceConfig struct {
	Port          int
	DB            DBConfig
	SirsiURL      string
	SaxonURL      string
	PDFServiceURL string
	IIIFManURL    string
	IIIFURL       string
	TrackSysURL   string
	APIURL        string
	WorkDir       string
	WriteKey      string
}

// LoadConfiguration will load the service configuration from the commandline
// and return a pointer to it. Any failures are fatal.
func LoadConfiguration() *ServiceConfig {
	log.Printf("INFO: loading configuration...")
	var cfg ServiceConfig
	flag.IntVar(&cfg.Port, "port", 8080, "API service port (default 8080)")
	flag.StringVar(&cfg.SirsiURL, "sirsi", "https://ils.lib.virginia.edu/uhtbin", "Sirsi URL")
	flag.StringVar(&cfg.SaxonURL, "saxon", "https://saxon-servlet.internal.lib.virginia.edu/SaxonServlet", "Saxon servlet URL")
	flag.StringVar(&cfg.PDFServiceURL, "pdf", "https://pdfservice.lib.virginia.edu/pdf", "PDF service URL")
	flag.StringVar(&cfg.IIIFManURL, "iiifman", "https://iiifman.lib.virginia.edu", "IIIF Manifest service URL")
	flag.StringVar(&cfg.IIIFURL, "iiif", "https://iiif.lib.virginia.edu/iiif", "IIIF service URL")
	flag.StringVar(&cfg.TrackSysURL, "tracksys", "https://tracksys2.lib.virginia.edu", "TrackSys URL")
	flag.StringVar(&cfg.APIURL, "api", "", "This API service URL")
	flag.StringVar(&cfg.WorkDir, "work", "/tmp", "Working dir")
	flag.StringVar(&cfg.WriteKey, "key", "", "Access key for POST requests")

	// DB connection params
	flag.StringVar(&cfg.DB.Host, "dbhost", "", "Database host")
	flag.IntVar(&cfg.DB.Port, "dbport", 3306, "Database port")
	flag.StringVar(&cfg.DB.Name, "dbname", "", "Database name")
	flag.StringVar(&cfg.DB.User, "dbuser", "", "Database user")
	flag.StringVar(&cfg.DB.Pass, "dbpass", "", "Database password")

	flag.Parse()

	if cfg.APIURL == "" {
		log.Fatal("Parameter api is required")
	}
	if cfg.DB.Host == "" {
		log.Fatal("Parameter dbhost is required")
	}
	if cfg.DB.Name == "" {
		log.Fatal("Parameter dbname is required")
	}
	if cfg.DB.User == "" {
		log.Fatal("Parameter dbuser is required")
	}
	if cfg.DB.Pass == "" {
		log.Fatal("Parameter dbpass is required")
	}
	if cfg.WriteKey == "" {
		log.Fatal("Parameter key is required")
	}

	log.Printf("[CONFIG] port          = [%d]", cfg.Port)
	log.Printf("[CONFIG] api           = [%s]", cfg.APIURL)
	log.Printf("[CONFIG] sirsi         = [%s]", cfg.SirsiURL)
	log.Printf("[CONFIG] saxon         = [%s]", cfg.SaxonURL)
	log.Printf("[CONFIG] tracksys      = [%s]", cfg.TrackSysURL)
	log.Printf("[CONFIG] pdf           = [%s]", cfg.PDFServiceURL)
	log.Printf("[CONFIG] iiifman       = [%s]", cfg.IIIFManURL)
	log.Printf("[CONFIG] iiif          = [%s]", cfg.IIIFURL)
	log.Printf("[CONFIG] dbhost        = [%s]", cfg.DB.Host)
	log.Printf("[CONFIG] dbport        = [%d]", cfg.DB.Port)
	log.Printf("[CONFIG] dbname        = [%s]", cfg.DB.Name)
	log.Printf("[CONFIG] dbuser        = [%s]", cfg.DB.User)
	log.Printf("[CONFIG] workDir       = [%s]", cfg.WorkDir)

	return &cfg
}
