# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcoppython/dcoppython-3.4.0_beta2.ebuild,v 1.2 2005/02/27 20:21:30 danarmak Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
MAXKDEVER=3.4.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE: Python bindings for DCOP"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/python"
PATCHES="$FILESDIR/no-gtk-glib-check.diff"


