# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kregexpeditor/kregexpeditor-3.4.3.ebuild,v 1.6 2005/12/10 07:17:09 chriswhite Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Editor for Regular Expressions"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86"
IUSE=""

KMEXTRA="doc/KRegExpEditor"
