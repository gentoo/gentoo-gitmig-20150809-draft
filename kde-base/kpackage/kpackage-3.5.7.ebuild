# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpackage/kpackage-3.5.7.ebuild,v 1.4 2007/08/12 14:56:04 philantrop Exp $
KMNAME=kdeadmin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE package manager (deb, rpm etc support; rudimentary ebuild support)"
KEYWORDS="alpha amd64 ia64 ~ppc x86"
IUSE="kdehiddenvisibility"
DEPEND=""
