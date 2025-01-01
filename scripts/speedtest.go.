package main

import (
	"bytes"
	"fmt"
	"io"
	"net"
	"net/http"
	"os"
	"time"
)

const (
	downloadURL    = "https://speed.cloudflare.com/100mb"
	uploadURL      = "https://speed.cloudflare.com/__down"
	uploadSize     = 10 * 1024 * 1024
	connectTimeout = 5 * time.Second

	colorRed    = "\033[31m"
	colorYellow = "\033[33m"
	colorGreen  = "\033[32m"
	colorReset  = "\033[0m"
)

func getSpeedColor(bps float64) string {
	mbps := bps / 1_000_000
	switch {
	case mbps >= 25:
		return colorGreen
	case mbps >= 2:
		return colorYellow
	default:
		return colorRed
	}
}

func formatSpeed(bps float64) string {
	color := getSpeedColor(bps)
	var speed string

	switch {
	case bps >= 1_000_000_000:
		speed = fmt.Sprintf("%.2f Gbps", bps/1_000_000_000)
	case bps >= 1_000_000:
		speed = fmt.Sprintf("%.2f Mbps", bps/1_000_000)
	case bps >= 1_000:
		speed = fmt.Sprintf("%.2f Kbps", bps/1_000)
	default:
		speed = fmt.Sprintf("%.2f bps", bps)
	}

	return color + speed + colorReset
}

func checkInternetConnection() bool {
	conn, err := net.DialTimeout("tcp", "8.8.8.8:53", connectTimeout)
	if err != nil {
		return false
	}
	if conn != nil {
		conn.Close()
		return true
	}
	return false
}

func main() {
	if !checkInternetConnection() {
		fmt.Println(colorRed + "Not connected to internet" + colorReset)
		os.Exit(1)
	}

	downloadSpeed := testDownload()
	fmt.Print("↓ ")
	fmt.Print(formatSpeed(downloadSpeed))

	uploadSpeed := testUpload()
	fmt.Print("\t↑ ")
	fmt.Println(formatSpeed(uploadSpeed))
}

func testDownload() float64 {
	start := time.Now()

	client := &http.Client{
		Timeout: 30 * time.Second,
	}

	resp, err := client.Get(downloadURL)
	if err != nil {
		fmt.Printf("Error during download test: %v\n", err)
		os.Exit(1)
	}
	defer resp.Body.Close()

	bytes, err := io.ReadAll(resp.Body)
	if err != nil {
		fmt.Printf("Error reading response: %v\n", err)
		os.Exit(1)
	}

	duration := time.Since(start).Seconds()
	bits := float64(len(bytes)) * 8
	return bits / duration
}

func testUpload() float64 {
	data := bytes.Repeat([]byte("0"), uploadSize)

	start := time.Now()

	req, err := http.NewRequest("POST", uploadURL, bytes.NewReader(data))
	if err != nil {
		fmt.Printf("Error creating upload request: %v\n", err)
		os.Exit(1)
	}

	req.ContentLength = int64(len(data))
	req.Header.Set("Content-Type", "application/octet-stream")

	client := &http.Client{
		Timeout: 30 * time.Second,
	}
	resp, err := client.Do(req)
	if err != nil {
		fmt.Printf("Error during upload test: %v\n", err)
		os.Exit(1)
	}
	defer resp.Body.Close()

	duration := time.Since(start).Seconds()
	bits := float64(len(data)) * 8
	return bits / duration
}
