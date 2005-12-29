# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kooka/kooka-3.4.2.ebuild,v 1.5 2005/12/29 10:48:02 greg_g Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Kooka is a KDE application which provides access to scanner hardware"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkscan)
	media-libs/tiff"
OLDDEPEND="~kde-base/libkscan-$PV"

KMCOPYLIB="libkscan libkscan"
KMEXTRACTONLY="libkscan"

# Fix detection of gocr (kde bug 90082). Applied to trunk upstream, but not backported to branch as of 3.4.2.
PATCHES1="${FILESDIR}/kdegraphics-3.4.1-gocr.patch"

# There's no ebuild for kadmos, and likely will never be since it isn't free, but you can enable this use flag
# to compile against the kadmos headers you installed yourself
PATCHES="$FILESDIR/configure-fix-kdegraphics-kadmos.patch"
myconf="$myconf --without-kadmos"
