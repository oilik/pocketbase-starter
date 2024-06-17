package main

import (
	"log"

	"github.com/pocketbase/pocketbase"
	"github.com/pocketbase/pocketbase/core"
)

func main() {
	app := pocketbase.New()

	// Event handler örneği (opsiyonel)
	app.OnBeforeServe().Add(func(e *core.ServeEvent) error {
		log.Println("Server is about to start...")
		return nil
	})

	if err := app.Start(); err != nil {
		log.Fatal(err)
	}
}