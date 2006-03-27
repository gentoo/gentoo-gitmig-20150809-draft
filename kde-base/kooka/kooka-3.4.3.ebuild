# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kooka/kooka-3.4.3.ebuild,v 1.9 2006/03/27 22:41:59 agriffis Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Kooka is a KDE application which provides access to scanner hardware"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
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
