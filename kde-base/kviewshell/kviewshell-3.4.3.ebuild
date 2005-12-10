# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kviewshell/kviewshell-3.4.3.ebuild,v 1.8 2005/12/10 22:30:38 kloeri Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Generic framework for viewer applications"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""
