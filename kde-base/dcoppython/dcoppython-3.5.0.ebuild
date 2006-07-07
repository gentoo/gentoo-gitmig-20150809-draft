# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcoppython/dcoppython-3.5.0.ebuild,v 1.10 2006/07/07 09:33:19 corsair Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
MAXKDEVER=3.5.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE: Python bindings for DCOP"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""
DEPEND="virtual/python"
PATCHES="$FILESDIR/no-gtk-glib-check.diff"

# Because this installs into /usr/lib/python2.3/..., it doesn't have SLOT=X.Y like the rest of KDE,
# and it installs into /usr entirely
SLOT="0"
src_compile() {
	kde_src_compile myconf
	myconf="$myconf --prefix=/usr"
	kde_src_compile configure make
}

