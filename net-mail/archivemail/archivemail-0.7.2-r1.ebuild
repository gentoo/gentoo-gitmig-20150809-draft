# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/archivemail/archivemail-0.7.2-r1.ebuild,v 1.3 2011/03/12 13:47:11 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils eutils

DESCRIPTION="Tool written in Python for archiving and compressing old email in mailboxes."
HOMEPAGE="http://archivemail.sourceforge.net/"
SRC_URI="mirror://sourceforge/archivemail/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="examples/* FAQ"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	distutils_src_prepare
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
