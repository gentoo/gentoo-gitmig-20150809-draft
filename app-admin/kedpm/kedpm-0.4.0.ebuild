# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kedpm/kedpm-0.4.0.ebuild,v 1.10 2005/01/10 14:36:01 sekretarz Exp $

inherit distutils eutils

DESCRIPTION="Ked Password Manager helps to manage large amounts of passwords and related information"
HOMEPAGE="http://kedpm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE="gtk2"

DEPEND="virtual/python
	>=sys-apps/sed-4"
RDEPEND="dev-python/pycrypto
	gtk2? ( >=dev-python/pygtk-2 )"

pkg_setup() {
	# If pygtk was compiled without gnome support, this command fails.
	# Dirty hack but there is no way to depend on package compiled
	# with specified USE flag.
	if use gtk2
	then
		grep gnome /var/db/pkg/dev-python/pygtk-*/USE &>/dev/null ||
			die "You need to compile pygtk-2 with gnome support!"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# We want documentation to install in /usr/share/doc/kedpm
	# not in /usr/share/kedpm as in original setup.py.
	epatch ${FILESDIR}/setup-doc.patch

	# If we don't compiling with GTK support, let's change default
	# frontend for kedpm to CLI.
	use gtk2 || sed -i -e 's/"gtk"  # default/"cli"  # default/' scripts/kedpm
}

src_install() {
	distutils_src_install
	dodoc AUTHORS CHANGES ChangeLog INSTALL NEWS PKG-INFO README
	cp -r test run_tests ${D}/usr/share/${PN}
}

pkg_postinst() {
	einfo
	einfo "You can test your kedpm installation running"
	einfo "cd /usr/share/${PN}/ && ./run_tests"
	einfo
}
