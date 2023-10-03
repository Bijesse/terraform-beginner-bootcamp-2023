// Declares a package name
package main

// imports the format GO package 
import (
//	"log"
	"fmt"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)


// defines the entry point ot the application
func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: Provider,
	})
	// format.printline
	fmt.Println("Hello, World!")
}

// in Go, a titlecase function (func that starts with capital letter) gets exported
func Provider() *schema.Provider {
	var p *schema.Provider
	p = &schema.Provider{
		ResourcesMap: map[string]*schema.Resource{

		},
		DataSourcesMap: map[string]*schema.Resource{

		},
		Schema: map[string]*schema.Schema{
			"endpoint": {
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint of the external service",
			},
			"token": {
				Type: schema.TypeString,
				Sensitive: true, // will hide the token in the logs
				Required: true,
				Description: "Bearer token for auth",
			},
			"user_uuid": {
				Type: schema.TypeString,
				Required: true,
				Description: "UUID for configuration",
				//ValidateFunc, validateUUID,
			},

		},
	}
	//p.ConfigureContextFunc = providerConfigure(p)
	return p
} 

// func validateUUID(v interface{}, k string) (ws []string, errors []error) {
// 	log.Print("validateUUID:start")
// 	value := v.(string)
// 	if _,err := uuid.Parse(value); err != nil {
// 		errors = append(errors, fmt.Errorf("invalid UUID format"))
// 	}
// 	log.Print("validateUUID:end")
	
// }