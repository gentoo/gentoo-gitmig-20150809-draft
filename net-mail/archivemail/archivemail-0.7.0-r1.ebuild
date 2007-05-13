# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/archivemail/archivemail-0.7.0-r1.ebuild,v 1.1 2007/05/13 10:15:24 tove Exp $

inherit eutils distutils

DESCRIPTION="Tool written in Python for archiving and compressing old email in mailboxes."
HOMEPAGE="http://archivemail.sourceforge.net/"
SRC_URI="mirror://sourceforge/archivemail/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""
DEPEND=">=dev-lang/python-2.3"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-fpname.patch"
}

src_test() {
	echo ">>> Test phase: ${CATEGORY}/${PF}"
	ln -sf "${S}"/archivemail "${S}"/archivemail.py
	"${S}"/test_archivemail.py || die "test_archivemail.py failed"
}

src_install() {
	distutils_src_install --install-data=/usr/share
	dodoc examples/* CHANGELOG FAQ README TODO || die "dodoc failed"
}
