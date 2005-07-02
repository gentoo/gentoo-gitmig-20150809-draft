# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkscan/libkscan-3.4.1.ebuild,v 1.4 2005/07/02 01:16:25 pylon Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE scanner library"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""
DEPEND="media-gfx/sane-backends"