# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdat/kdat-3.5.7.ebuild,v 1.7 2007/08/19 15:10:25 nixnut Exp $
KMNAME=kdeadmin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="tar-based DAT archiver for KDE"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE="kdehiddenvisibility"
DEPEND=""
