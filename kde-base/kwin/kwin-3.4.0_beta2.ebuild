# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwin/kwin-3.4.0_beta2.ebuild,v 1.2 2005/02/05 14:43:57 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE window manager"
KEYWORDS="~x86"
IUSE=""

KMEXTRACTONLY="kcontrol/style/configure.in.in" # for the LIB_XRENDER check, for kompmgr.
						# bugs.kde.org 98615
