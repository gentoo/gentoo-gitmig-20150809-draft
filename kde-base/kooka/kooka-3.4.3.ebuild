# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kooka/kooka-3.4.3.ebuild,v 1.8 2005/12/29 10:45:50 greg_g Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Kooka is a KDE application which provides access to scanner hardware"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkscan)
	media-libs/tiff"
OLDDEPEND="~kde-base/libkscan-$PV"

KMCOPYLIB="libkscan libkscan"
KMEXTRACTONLY="libkscan"

# Fix detection of gocr (kde bug 90082). Applied for 3.5.
PATCHES1="${FILESDIR}/kdegraphics-3.4.1-gocr.patch"

# There's no ebuild for kadmos, and likely will never be since it isn't free.
PATCHES="$FILESDIR/configure-fix-kdegraphics-kadmos.patch"
myconf="$myconf --without-kadmos"
