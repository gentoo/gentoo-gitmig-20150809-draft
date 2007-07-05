# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/archivemail/archivemail-0.6.1-r1.ebuild,v 1.7 2007/07/05 01:15:28 hawking Exp $

inherit distutils

DESCRIPTION="Tool written in Python for archiving and compressing old email in mailboxes."
HOMEPAGE="http://archivemail.sourceforge.net/"
SRC_URI="mirror://sourceforge/archivemail/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~amd64"
IUSE=""
DEPEND=">=dev-lang/python-2.0
		>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	# Assigning to None returns a syntax warning in Python 2.3
	sed -ie 's/(None, last_dir)/(junk, last_dir)/' ${S}/archivemail
}

src_install() {
	DOCS="FAQ"
	distutils_src_install
	dodoc examples/*
}
