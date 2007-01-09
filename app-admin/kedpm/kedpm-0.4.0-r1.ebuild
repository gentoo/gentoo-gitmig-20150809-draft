# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kedpm/kedpm-0.4.0-r1.ebuild,v 1.2 2007/01/09 20:50:55 dev-zero Exp $

inherit distutils eutils

DESCRIPTION="Ked Password Manager helps to manage large amounts of passwords and related information"
HOMEPAGE="http://kedpm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="gtk"

DEPEND=">=sys-apps/sed-4"
RDEPEND="dev-python/pycrypto
	gtk? ( >=dev-python/pygtk-2 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# We want documentation to install in /usr/share/doc/kedpm
	# not in /usr/share/kedpm as in original setup.py.
	epatch "${FILESDIR}/setup-doc.patch"

	# If we don't compiling with GTK support, let's change default
	# frontend for kedpm to CLI.
	use gtk || sed -i -e 's/"gtk"  # default/"cli"  # default/' scripts/kedpm
}

src_install() {
	DOCS="AUTHORS CHANGES NEWS"
	distutils_src_install
	# menu item
	domenu "${FILESDIR}/${PN}.desktop"
}

src_test() {
	./run_tests || die "tests failed"
}
