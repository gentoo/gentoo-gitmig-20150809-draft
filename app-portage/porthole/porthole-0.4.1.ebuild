# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/porthole/porthole-0.4.1.ebuild,v 1.6 2005/06/24 17:38:21 agriffis Exp $

inherit distutils

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
	local gnome_flag=false

	for pygtk_install in /var/db/pkg/dev-python/pygtk*; do
		cd ${pygtk_install} || die
		if [[ $(<SLOT) == 2 && " $(<USE) " == *" gnome "* ]]; then
			gnome_flag=true
			break
		fi
	done

	if ! ${gnome_flag}; then
		echo
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
