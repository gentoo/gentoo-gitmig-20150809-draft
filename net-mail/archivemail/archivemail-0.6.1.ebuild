# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/archivemail/archivemail-0.6.1.ebuild,v 1.1 2003/03/12 03:09:56 g2boojum Exp $

DESCRIPTION="Tool written in Python for archiving and compressing old email in mailboxes."
HOMEPAGE="http://archivemail.sourceforge.net/"
SRC_URI="mirror://sourceforge/archivemail/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.0"

S=${WORKDIR}/${P}

inherit distutils

src_install() {
	mydoc="CHANGELOG COPYING FAQ MANIFEST PKG-INFO README TODO"
	distutils_src_install
	dodoc examples/*
}
	
