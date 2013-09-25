#!/bin/bash

source tests-common.sh

inherit git-r3

testdir=${pkg_root}/git
mkdir "${testdir}" || die "unable to mkdir testdir"
cd "${testdir}" || die "unable to cd to testdir"

EGIT3_STORE_DIR=store
mkdir "${EGIT3_STORE_DIR}" || die "unable to mkdir store"

test_file() {
	local message=${1}
	local fn=${2}
	local expect=${3}

	tbegin "${message}"
	if [[ ! -f ${fn} ]]; then
		tend 1
		eerror "${fn} does not exist (not checked out?)"
	else
		local got=$(<"${fn}")

		if [[ ${got} != ${expect} ]]; then
			tend 1
			eerror "${fn}, expected: ${expect}, got: ${got}"
		else
			tend 0
			return 0
		fi
	fi
	return 1
}

test_repo_clean() {
	(
		mkdir repo
		cd repo
		git init -q
		echo test > file
		git add file
		git commit -m 1 -q
		echo other-text > file
		git add file
		git commit -m 2 -q
	) || die "unable to prepare repo"

	# we need to use an array to preserve whitespace
	EGIT_REPO_URI=(
		'ext::git daemon --export-all --base-path=. --inetd %G/repo'
	)

	tbegin "fetching from a simple repo"
	( git-r3_fetch ) &> fetch.log
	if tend ${?}; then
		tbegin "checkout of a simple repo"
		( git-r3_checkout ) &>> fetch.log
		if tend ${?}; then
			test_file "results of checking out a simple repo" \
				"${WORKDIR}/${P}/file" other-text \
				&& return 0
		fi
	fi

	cat fetch.log
	return 1
}

test_repo_clean

texit
