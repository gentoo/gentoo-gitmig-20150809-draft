# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfile-lnk/kfile-lnk-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:32 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kfile-plugins/lnk"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kfile plugin for Windows .lnk files and command-line tool for exctracting target URLs from these files"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

