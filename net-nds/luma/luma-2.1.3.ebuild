# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/luma/luma-2.1.3.ebuild,v 1.6 2008/05/13 18:30:08 hawking Exp $

inherit eutils qt3

DESCRIPTION="Luma is a graphical utility for accessing and managing data stored on LDAP servers."
HOMEPAGE="http://luma.sourceforge.net/"
SRC_URI="mirror://sourceforge/luma/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~sparc x86"
IUSE="samba"

RDEPEND="$(qt_min_version 3.2)
	>=dev-lang/python-2.3
	>=dev-python/PyQt-3.10
	>=dev-python/python-ldap-2.0.1
	samba? ( >=dev-python/py-smbpasswd-1.0 )"
DEPEND="$(qt_min_version 3.2)
	>=dev-lang/python-2.3
	>=dev-python/PyQt-3.10
	>=dev-python/python-ldap-2.0.1
	samba? ( >=dev-python/py-smbpasswd-1.0 )"

src_install() {
	# need to update files for newer sip/pyqt versions (SizePolicy: int -> enum)
	# if $QTDIR/etc/settings/qtrc file exists, the qt build tools try to create
	[ -d "$QTDIR/etc/settings" ] && addwrite "$QTDIR/etc/settings"
	addpredict "$QTDIR/etc/settings"
	for F in `find . -iname "*\.ui"` ; do
		rm ${F%ui}py
		pyuic ${F} > ${F%ui}py
	done

	dodir /usr
	python install.py --prefix="${D}"/usr
	make_desktop_entry "luma" Luma "/usr/share/luma/icons/luma-128.png" "System;Qt"
}
