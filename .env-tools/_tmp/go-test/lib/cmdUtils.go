package lib

import (
	"bufio"
	"fmt"
	"os/exec"
	"strings"
)

func ExecCmd(rootCmd string, args ...string) error {
	cmd := exec.Command(rootCmd, args...)

	stdout, err := cmd.StdoutPipe()
	if err != nil {
		return err
	}
	scanner := bufio.NewScanner(stdout)
	err = cmd.Start()
	if err != nil {
		return err
	}
	for scanner.Scan() {
		Log(CMD_STDOUT, scanner.Text())
	}
	if scanner.Err() != nil {
		cmd.Process.Kill()
		cmd.Wait()
		Log(CMD_STDOUT, scanner.Err().Error())
		return scanner.Err()
	}
	return cmd.Wait()
}

type LogLevel string

/* var Reset = "\033[0m"
var Red = "\033[31m"
var Green = "\033[32m"
var Yellow = "\033[33m"
var Blue = "\033[34m"
var Magenta = "\033[35m"
var Cyan = "\033[36m"
var Gray = "\033[37m"
var White = "\033[97m" */

const (
	INFO       LogLevel = "info"
	CMD_STDOUT LogLevel = "cmd_stdout"
	WARNING    LogLevel = "warning"
	SUCCESS    LogLevel = "success"
	DANGER     LogLevel = "danger"
)

func Log(level LogLevel, msg string) {
	colors := map[LogLevel]string{
		INFO:       "\033[34m",
		CMD_STDOUT: "\033[37m",
		WARNING:    "\033[33m",
		SUCCESS:    "\033[32m",
		DANGER:     "\033[31m",
	}

	color := colors[level]
	prefix := strings.ToUpper(string(level))

	fmt.Printf("%s[%s] %s\n", color, prefix, msg)
}
