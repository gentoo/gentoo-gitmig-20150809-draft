# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/mpeglib/mpeglib-3.4.0_beta1.ebuild,v 1.2 2005/01/23 21:03:55 greg_g Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mpeg library"
KEYWORDS="~x86"
IUSE=""
DEPEND="media-sound/cdparanoia"

if [ "${ARCH}" != "amd64" ] ; then
	PATCHES="${FILESDIR}/kdemultimedia-64bit.patch"
fi

myconf="--with-cdparanoia --enable-cdparanoia"
