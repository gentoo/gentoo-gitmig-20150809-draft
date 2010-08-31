# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/archivemail/archivemail-0.8.0.ebuild,v 1.1 2010/08/31 06:18:39 radhermit Exp $

EAPI="3"

PYTHON_DEPEND="2"
inherit distutils python

DESCRIPTION="Tool written in Python for archiving and compressing old email in mailboxes."
HOMEPAGE="http://archivemail.sourceforge.net/"
SRC_URI="mirror://sourceforge/archivemail/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DOCS="examples/* FAQ"

src_prepare() {
	# Fix tests for python-2.7
	sed -i -e 's:\(fp_archive = \)FixedGzipFile:\1gzip.GzipFile:' \
		test_archivemail || die "sed failed"
}

src_test() {
	echo ">>> Test phase: ${CATEGORY}/${PF}"
	"${S}"/test_archivemail || die "test_archivemail failed"
}

src_install() {
	distutils_src_install --install-data=/usr/share
}
