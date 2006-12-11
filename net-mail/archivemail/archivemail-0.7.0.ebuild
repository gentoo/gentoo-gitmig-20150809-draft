# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/archivemail/archivemail-0.7.0.ebuild,v 1.1 2006/12/11 06:22:06 tove Exp $

DESCRIPTION="Tool written in Python for archiving and compressing old email in mailboxes."
HOMEPAGE="http://archivemail.sourceforge.net/"
SRC_URI="mirror://sourceforge/archivemail/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""
DEPEND=">=dev-lang/python-2.3"

src_test() {
	vecho ">>> Test phase: ${CATEGORY}/${PF}"
	cp "${S}"/archivemail "${S}"/archivemail.py
	"${S}"/test_archivemail.py || die "test_archivemail.py failed"
}

src_install() {
	# braindead setup.py, so just install the old-fashioned way
	dobin archivemail || die "dobin failed"
	doman archivemail.1 || die "doman failed"
	dodoc examples/* CHANGELOG FAQ README TODO || die "dodoc failed"
}
