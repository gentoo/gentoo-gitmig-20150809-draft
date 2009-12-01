# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-wallpapers/kdebase-wallpapers-4.3.4.ebuild,v 1.1 2009/12/01 10:19:19 wired Exp $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="wallpapers"
inherit kde4-meta

DESCRIPTION="KDE wallpapers"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

add_blocker kde-wallpapers
