# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-irc/cl-irc-0.6.0.ebuild,v 1.1 2004/10/15 03:52:10 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A Common Lisp IRC client library"
HOMEPAGE="http://common-lisp.net/project/cl-irc/"
# Upstream is a mess at the moment.
# SRC_URI="ftp://common-lisp.net/pub/project/cl-irc/${P}.tar.gz"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/${PN}/${PN}_${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cl-split-sequence"

CLPACKAGE=cl-irc

src_unpack() {
	unpack ${A}
	rm ${S}/Makefile
}

src_install() {
	common-lisp-install cl-irc.asd *.lisp
	common-lisp-system-symlink
	dodoc CREDITS ChangeLog LICENSE README TODO
	docinto doc
	dodoc doc/*.txt
	docinto example
	dodoc example/*
	do-debian-credits
}
