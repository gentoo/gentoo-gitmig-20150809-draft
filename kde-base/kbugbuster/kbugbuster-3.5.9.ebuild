# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kbugbuster/kbugbuster-3.5.9.ebuild,v 1.2 2008/03/04 01:23:32 jer Exp $

KMNAME=kdesdk
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KBugBuster - A tool for checking and reporting KDE apps' bugs"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kcal kdehiddenvisibility"

DEPEND="kcal? ( >=kde-base/libkcal-${PV}:${SLOT} )"

#TODO tell configure about the optional kcal support, or something
