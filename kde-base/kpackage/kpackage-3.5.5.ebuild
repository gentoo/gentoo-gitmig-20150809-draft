# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpackage/kpackage-3.5.5.ebuild,v 1.7 2006/12/11 11:03:03 kloeri Exp $
KMNAME=kdeadmin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE package manager (deb, rpm etc support; rudimentary ebuild support)"
KEYWORDS="alpha amd64 ia64 ppc x86"
IUSE="kdehiddenvisibility"
DEPEND=""

