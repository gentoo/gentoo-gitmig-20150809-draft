# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/archivemail/archivemail-0.7.2-r1.ebuild,v 1.2 2008/07/09 08:28:29 opfer Exp $

inherit distutils eutils

DESCRIPTION="Tool written in Python for archiving and compressing old email in mailboxes."
HOMEPAGE="http://archivemail.sourceforge.net/"
SRC_URI="mirror://sourceforge/archivemail/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc x86"
IUSE=""
DEPEND=">=dev-lang/python-2.3"

DOCS="examples/* FAQ"

src_unpack() {
	distutils_src_unpack
	epatch "${FILESDIR}/0.7.2-empty_maildir-r266.patch"
}

src_test() {
	echo ">>> Test phase: ${CATEGORY}/${PF}"
	ln -sf "${S}"/archivemail "${S}"/archivemail.py
	"${S}"/test_archivemail.py || die "test_archivemail.py failed"
}

src_install() {
	distutils_src_install --install-data=/usr/share
}
