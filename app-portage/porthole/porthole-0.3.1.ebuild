# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/porthole/porthole-0.3.1.ebuild,v 1.6 2004/10/17 09:59:24 dholm Exp $

DESCRIPTION="A GTK+-based frontend to Portage"
HOMEPAGE="http://porthole.sourceforge.net"
SRC_URI="mirror://sourceforge/porthole/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND=">=dev-lang/python-2.3
		>=dev-python/pygtk-2.0.0
		>=dev-python/pyxml-0.8.3"

pkg_setup() {

	local gnome_flag=""

	for pygtk_install in /var/db/pkg/dev-python/pygtk*; do
		if grep 2 ${pygtk_install}/SLOT > /dev/null; then
			for flag in `cat ${pygtk_install}/USE`; do
				if [ ${flag} == gnome ]; then
					gnome_flag="found"
				fi
			done
		fi
	done

	if [ -z "${gnome_flag}" ]; then
		echo
		eerror "pygtk was not merged with the gnome"
		eerror "USE flag. Porthole requires pygtk be"
		eerror "built with this flag for libglade support."
		die "pygtk missing gnome support"
	fi
}

src_install() {
	python setup.py install --root=${D} || die
	chmod -R a+r ${D}/usr/share/porthole
	chmod -R a+r ${D}/usr/share/doc/porthole-${PV}
}
