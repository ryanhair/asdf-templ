#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/a-h/templ"
TOOL_NAME="templ"
TOOL_TEST="templ version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

get_os() {
  os=$(uname -s)
  case $os in
  Darwin) os="Darwin" ;;
  Linux) os="Linux" ;;
  *) fail "The os (${os}) is not supported by this installation script." ;;
  esac
  echo "$os"
}

get_arch() {
  arch=$(uname -m)
  case $arch in
  x86_64) arch="x86_64" ;;
  arm64) arch="arm64" ;;
  *) fail "The architecture (${arch}) is not supported by this installation script." ;;
  esac
  echo "$arch"
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if templ is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//'
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	arch=$(get_arch)
  os=$(get_os)
	url="$GH_REPO/releases/download/v${version}/templ_${os}_${arch}.tar.gz"
	echo "* Downloading $TOOL_NAME release $version..."
	mkdir templdir
	curl "${curl_opts[@]}" -C - "$url" | tar -zx -C $filename || fail "Could not download $url"
	mv templdir/templ $filename
	echo "filename: $filename"
	ls

	rm -rf templdir
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
