# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/luma/luma-2.4.ebuild,v 1.1 2008/05/13 18:30:08 hawking Exp $

NEED_PYTHON=2.3

inherit eutils python qt3

DESCRIPTION="Luma is a graphical utility for accessing and managing data stored on LDAP servers."
HOMEPAGE="http://luma.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="samba"

RDEPEND="$(qt_min_version 3.2)
	>=dev-python/PyQt-3.10
	>=dev-python/python-ldap-2.0.1
	samba? ( >=dev-python/py-smbpasswd-1.0 )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# We do the optimization seperately
	sed -i \
		-e '/^doCompile/d' \
		install.py || "sed failed"
}

src_install() {
	# if $QTDIR/etc/settings/qtrc file exists, the qt build tools try to create
	[ -d "$QTDIR/etc/settings" ] && addwrite "$QTDIR/etc/settings"
	addpredict "$QTDIR/etc/settings"

	dodir /usr

	python_version
	"${python}" install.py --prefix="${D}/usr"
	make_desktop_entry "luma" Luma "/usr/share/luma/icons/luma-128.png" "System;Qt"
}

# Maintainer-Info:
# Luma installs it's stuff to /usr/lib/luma, even on 64bit-systems.

pkg_postinst() {
	python_mod_optimize /usr/lib/luma
}

pkg_postrm() {
	python_mod_cleanup /usr/lib/luma
}
