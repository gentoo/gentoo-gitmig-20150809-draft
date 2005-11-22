# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kbugbuster/kbugbuster-3.5.0.ebuild,v 1.1 2005/11/22 22:13:58 danarmak Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KBugBuster - A tool for checking and reporting KDE apps' bugs"
KEYWORDS="~amd64 ~x86"
IUSE="kcal"


DEPEND="kcal? ( $(deprange $PV $MAXKDEVER kde-base/libkcal) )"

#TODO tell configure about the optional kcal support, or something
