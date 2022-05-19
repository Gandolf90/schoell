#!/bin/bash

BaseDir="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

run() {
	printHeader
	DeployChoice

	printFooterExit
}

DeployChoice () {
	echo ""
	echo "Start Deploy? (y/n)"
	echo -n "  "
	read UserChoice

	if [ "$UserChoice" = "n" ] || [ "$UserChoice" = "e" ]; then
		printFooterExit
		return
	fi
  echo ""
  
	if [ "$UserChoice" = "y" ]; then
	  echoWarning " Deploy START"
    echo ""

	  DeployLive
	fi
}

DeployLive () {
	echo "Version?"
	echo -n "  "
	read Version

	echo ""
	echoCountdown 5

	docker login

	echo "docker buildx build --platform linux/amd64,linux/arm64 --push -t gandolf90/schoell:$Version ."
  docker buildx build --platform linux/amd64,linux/arm64 --push -t gandolf90/schoell:$Version .

  echo ""
  echo "docker buildx build --platform linux/amd64,linux/arm64 --push -t gandolf90/schoell:latest ."
  docker buildx build --platform linux/amd64,linux/arm64 --push -t gandolf90/schoell:latest .

}

printHeader () {
	clear
	echo ""
	echoWarning "----------------------------------------------------------------"
	echoSuccess "---                      Deploy LIVE                         ---"
	echoWarning "----------------------------------------------------------------"
	echo ""
}

printFooterExit() {
	echo ""
	echoWarning "----------------------------------------------------------------"
	echoSuccess "---                E N D   O F   L I N E                     ---"
	echoWarning "----------------------------------------------------------------"
	echo ""
}

echoCountdown() {
  echoHighlight "You can now cancel within $1 seconds using CTRL-C"
		echo -n "  "
		for (( a=$1; a>0; a--)); do
			echo -n "$a..."
			sleep 1;
		done
	echoSuccess " continuing"
	echo ""
}

echoAlert () {
	echo -e "\033[1;31m$1"
	tput sgr0
}

echoSuccess () {
	echo -e "\033[1;32m$1"
	tput sgr0
}

echoWarning () {
	echo -e "\033[1;33m$1"
	tput sgr0
}

echoHighlight () {
	echo -e "\033[1;36m$1"
	tput sgr0
}

run

