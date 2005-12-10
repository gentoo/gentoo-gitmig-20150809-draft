# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kbstateapplet/kbstateapplet-3.4.3.ebuild,v 1.7 2005/12/10 22:56:58 kloeri Exp $
KMNAME=kdeaccessibility
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE panel applet that displays the keyboard status"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/kcontrol)"

