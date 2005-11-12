# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-wallpapers/kdeartwork-wallpapers-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:25 danarmak Exp $

KMMODULE=wallpapers
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Wallpapers from kde"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
