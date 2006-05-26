# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kbstateapplet/kbstateapplet-3.5.2.ebuild,v 1.4 2006/05/26 15:37:23 wolf31o2 Exp $
KMNAME=kdeaccessibility
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE panel applet that displays the keyboard status"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/kcontrol)"

