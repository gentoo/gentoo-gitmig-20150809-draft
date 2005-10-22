# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kbstateapplet/kbstateapplet-3.5.0_beta2.ebuild,v 1.2 2005/10/22 06:32:16 halcy0n Exp $
KMNAME=kdeaccessibility
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE panel applet that displays the keyboard status"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/kcontrol)"

