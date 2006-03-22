# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kbugbuster/kbugbuster-3.5.2.ebuild,v 1.1 2006/03/22 20:14:57 danarmak Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KBugBuster - A tool for checking and reporting KDE apps' bugs"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="kcal"


DEPEND="kcal? ( $(deprange $PV $MAXKDEVER kde-base/libkcal) )"

#TODO tell configure about the optional kcal support, or something
