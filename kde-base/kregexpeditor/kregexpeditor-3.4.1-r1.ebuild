# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kregexpeditor/kregexpeditor-3.4.1-r1.ebuild,v 1.1 2005/09/20 10:19:15 greg_g Exp $

KMNAME=kdeutils
MAXKDEVER=3.4.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Editor for Regular Expressions"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""

KMEXTRA="doc/KRegExpEditor"
