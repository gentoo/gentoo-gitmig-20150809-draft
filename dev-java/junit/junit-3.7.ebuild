# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: William McArthur <Leknor@Leknor.com>
# $Header $

NP="junit3.7"
S=${WORKDIR}/${NP}
DESCRIPTION="JUnit is a simple framework to write repeatable tests."
SRC_URI="http://download.sourceforge.net/junit/${NP}.zip"
HOMEPAGE="http://JUnit.org"

DEPEND="virtual/jdk-1.3"

src_unpack() {
	unpack ${NP}.zip
}

src_install () {
	dojar junit.jar src.jar
	dohtml -r README.html doc  javadoc
}

