# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/mpeglib/mpeglib-3.4.1.ebuild,v 1.6 2005/07/08 04:11:05 weeve Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mpeg library"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="media-sound/cdparanoia"

myconf="--with-cdparanoia --enable-cdparanoia"

PATCHES="${FILESDIR}/kdemultimedia-3.4.0-amd64.patch"
