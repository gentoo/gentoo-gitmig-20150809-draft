# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfile-desktop/kfile-desktop-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:17 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kfile-plugins/desktop"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kfile plugin for .desktop files"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

