# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kbugbuster/kbugbuster-3.5.9.ebuild,v 1.1 2008/02/20 22:38:52 philantrop Exp $

KMNAME=kdesdk
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KBugBuster - A tool for checking and reporting KDE apps' bugs"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kcal kdehiddenvisibility"

DEPEND="kcal? ( >=kde-base/libkcal-${PV}:${SLOT} )"

#TODO tell configure about the optional kcal support, or something
