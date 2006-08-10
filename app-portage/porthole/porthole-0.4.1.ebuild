# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/porthole/porthole-0.4.1.ebuild,v 1.9 2006/08/10 16:24:41 truedfx Exp $

inherit distutils eutils

DESCRIPTION="A GTK+-based frontend to Portage"
HOMEPAGE="http://porthole.sourceforge.net"
SRC_URI="mirror://sourceforge/porthole/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="debug"
DEPEND=">=dev-lang/python-2.3
	>=sys-apps/portage-2.0.51-r3
	>=dev-python/pygtk-2.0.0
	>=dev-python/pyxml-0.8.3"

RDEPEND="${DEPEND} debug? ( >=dev-python/pycrash-0.4_pre3 )"

pkg_setup() {
	if has_version '<dev-python/pygtk-2.8.0-r2' &&
	   ! built_with_use dev-python/pygtk gnome ; then
		eerror "pygtk was not merged with the gnome"
		eerror "USE flag. Porthole requires pygtk be"
		eerror "built with this flag for libglade support."
		die "pygtk missing gnome support"
	fi
}

src_install() {
	distutils_src_install
	chmod -R a+rX ${D}/usr/share/porthole
	dodoc TODO README NEWS AUTHORS
	keepdir /var/log/porthole
	fperms g+w /var/log/porthole
}

pkg_preinst() {
	chgrp portage ${IMAGE}/var/log/porthole
}
