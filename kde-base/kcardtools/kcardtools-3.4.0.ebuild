# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcardtools/kcardtools-3.4.0.ebuild,v 1.2 2005/03/18 17:24:23 morfic Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE smartcard tools"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

pkg_setup() {
	# ugly search if libksmartcard from kdelibs is compiled. The same is done by configure
	if [ ! -f $PREFIX/include/kcarddb.h ]; then
		eerror "Can't find $PREFIX/include/kcarddb.h"
		eerror "You need to recompile kdelibs with the libksmartcard support!"
		die
	fi
}