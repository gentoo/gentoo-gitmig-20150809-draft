# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konqueror/konqueror-3.5.0-r1.ebuild,v 1.4 2006/03/28 00:26:28 agriffis Exp $

KMNAME=kdebase
# Note: we need >=kdelibs-3.3.2-r1, but we don't want 3.3.3!
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-${PV}-patches-1.tar.bz2"

DESCRIPTION="KDE: Web browser, file manager, ..."
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="java"

DEPEND="
$(deprange $PV $MAXKDEVER kde-base/libkonq)"

RDEPEND="${DEPEND}
$(deprange $PV $MAXKDEVER kde-base/kcontrol)
$(deprange $PV $MAXKDEVER kde-base/kdebase-kioslaves)
java? ( >=virtual/jre-1.4 )"

KMCOPYLIB="libkonq libkonq"
KMEXTRACTONLY=kdesktop/KDesktopIface.h

src_unpack() {
	unpack "kdebase-${PV}-patches-1.tar.bz2"
	kde-meta_src_unpack

	# Fix the location bar focus, bug 114329.
	epatch "${WORKDIR}/patches/${P}-location-bar-focus.patch"
}
