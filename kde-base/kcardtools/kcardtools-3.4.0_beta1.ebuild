# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcardtools/kcardtools-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:28 danarmak Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE smartcard tools"
KEYWORDS="~x86"
IUSE=""

pkg_setup() {
	# ugly search if libksmartcard from kdelibs is compiled. The same is done by configure
	if [ ! -f $PREFIX/include/kcarddb.h ]; then
		eerror "Can't find $PREFIX/include/kcarddb.h"
		eerror "You need to recompile kdelibs with the libksmartcard support!"
		die
	fi
}