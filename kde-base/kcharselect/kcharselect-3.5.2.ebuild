# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcharselect/kcharselect-3.5.2.ebuild,v 1.13 2007/02/03 09:27:08 mr_bones_ Exp $

KMNAME=kdeutils
MAXKDEVER=3.5.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE character selection utility"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

KMEXTRA="charselectapplet/"
