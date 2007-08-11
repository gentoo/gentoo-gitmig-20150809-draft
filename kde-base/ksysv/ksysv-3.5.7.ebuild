# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksysv/ksysv-3.5.7.ebuild,v 1.4 2007/08/11 17:26:40 armin76 Exp $
KMNAME=kdeadmin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE: Editor for Sys-V like init configurations"
KEYWORDS="alpha ~amd64 ia64 ~ppc ppc64 x86"
IUSE="kdehiddenvisibility"
DEPEND=""
