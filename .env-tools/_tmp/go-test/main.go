package main

import (
	"fmt"
	"log"
	"os"

	"github.com/urfave/cli/v2"
	"github.com/wheelebin/go-test/patches"
)

func main() {
	app := &cli.App{
		Commands: []*cli.Command{
			{
				Name:    "install",
				Aliases: []string{"i"},
				Usage:   "install all default patches",
				Action: func(cCtx *cli.Context) error {
					patches.Test()
					fmt.Println("added task: ", cCtx.Args().First())
					return nil
				},
			},
		},
	}

	if err := app.Run(os.Args); err != nil {
		log.Fatal(err)
	}
}
