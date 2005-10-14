# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kooka/kooka-3.5.0_beta2.ebuild,v 1.1 2005/10/14 18:41:57 danarmak Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Kooka is a KDE application which provides access to scanner hardware"
KEYWORDS="~amd64"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkscan)
	media-libs/tiff"


KMCOPYLIB="libkscan libkscan"
KMEXTRACTONLY="libkscan"

# There's no ebuild for kadmos, and likely will never be since it isn't free.
myconf="$myconf --without-kadmos"
