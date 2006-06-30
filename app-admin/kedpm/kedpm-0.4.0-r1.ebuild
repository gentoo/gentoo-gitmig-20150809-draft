# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kedpm/kedpm-0.4.0-r1.ebuild,v 1.1 2006/06/30 13:50:58 dragonheart Exp $

inherit distutils eutils

DESCRIPTION="Ked Password Manager helps to manage large amounts of passwords and related information"
HOMEPAGE="http://kedpm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="gtk"

DEPEND="virtual/python
	>=sys-apps/sed-4"
RDEPEND="dev-python/pycrypto
	gtk? ( >=dev-python/pygtk-2 )"

pkg_setup() {
	if use gtk
	then
		if has_version '<dev-python/pygtk-2.8.0-r2' ; then
			if ! built_with_use dev-python/pygtk gnome
			then
				die "You need to compile dev-python/pygtk with gnome USE flag!"
			fi
		fi
	fi
}

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
	distutils_src_install
	dodoc AUTHORS CHANGES ChangeLog NEWS PKG-INFO README
	cp -r test run_tests "${D}/usr/share/${PN}"
	# menu item
	domenu "${FILESDIR}/${PN}.desktop"

}

pkg_postinst() {
	einfo
	einfo "You can test your kedpm installation running"
	einfo "cd /usr/share/${PN}/ && ./run_tests"
	einfo
}
