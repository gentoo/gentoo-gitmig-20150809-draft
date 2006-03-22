# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/mpeglib/mpeglib-3.5.1.ebuild,v 1.2 2006/03/22 20:15:45 danarmak Exp $

KMNAME=kdemultimedia
MAXKDEVER=3.5.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mpeg library"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="media-sound/cdparanoia"

myconf="--with-cdparanoia --enable-cdparanoia"
