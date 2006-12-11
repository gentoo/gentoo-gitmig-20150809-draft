# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kappfinder/kappfinder-3.5.5.ebuild,v 1.9 2006/12/11 11:44:48 kloeri Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE tool that looks for well-known apps in your path and creates .desktop files for them in the KDE menu"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

RDEPEND="$(deprange $PV $MAXKDEVER kde-base/kicker)"
