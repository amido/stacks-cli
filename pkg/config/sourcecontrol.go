package config

type SourceControl struct {
	Type string `mapstructure:"type"`
	URL  string `mapstructure:"url"`
}
