# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/porthole/porthole-0.3.ebuild,v 1.1 2004/05/01 13:36:55 port001 Exp $

DESCRIPTION="A GTK+-based frontend to Portage"
HOMEPAGE="http://porthole.sourceforge.net"
SRC_URI="mirror://sourceforge/porthole/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=gnome-base/libglade-2
	>=dev-python/pygtk-2.0.0"

src_install() {
	python setup.py install --root=${D} || die
	chmod -R a+r ${D}/usr/share/porthole
	chmod -R a+r ${D}/usr/doc/porthole-0.3
}
