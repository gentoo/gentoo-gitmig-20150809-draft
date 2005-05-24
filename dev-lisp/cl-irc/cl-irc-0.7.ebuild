# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-irc/cl-irc-0.7.ebuild,v 1.3 2005/05/24 18:48:33 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A Common Lisp IRC client library"
HOMEPAGE="http://common-lisp.net/project/cl-irc/"
SRC_URI="ftp://common-lisp.net/pub/project/cl-irc/cl-irc-${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/cl-split-sequence"

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
