# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/mit-scheme/mit-scheme-7.7.1.ebuild,v 1.1 2004/01/15 18:45:23 hhg Exp $

MY_P="scheme-${PV}"
MY_SUF="-ix86-gnu-linux"
S="${WORKDIR}"
DESCRIPTION="GNU/MIT-Scheme Binary package"
HOMEPAGE="http://www.swiss.ai.mit.edu/projects/scheme/"
SRC_URI="http://ftp.gnu.org/gnu/mit-scheme/stable.pkg/${PV}/${P}${MY_SUF}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_unpack() {
	unpack ${A}

	echo "#!/bin/bash" > scheme
	echo "/opt/mit-scheme/bin/scheme -library /opt/mit-scheme/lib/mit-scheme \$*" >> scheme

	echo "#!/bin/bash" > bchscheme
	echo "/opt/mit-scheme/bin/bchscheme -library /opt/mit-scheme/lib/mit-scheme \$*" >> bchscheme
}

src_install() {
	dodir /opt/mit-scheme/lib
	dodir /opt/mit-scheme/bin

	into /opt/mit-scheme
	dobin bin/*

	dodoc lib/mit-scheme/doc/COPYING
	dohtml lib/mit-scheme/doc/*html
	doinfo lib/mit-scheme/edwin/info/*
	rm -rf lib/mit-scheme/doc
	rm -rf lib/mit-scheme/edwin/info
	cp -R lib/* ${D}opt/mit-scheme/lib

	into /usr
	dobin scheme bchscheme
}
