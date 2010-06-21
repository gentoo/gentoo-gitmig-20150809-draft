# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-menu/kdebase-menu-4.3.5.ebuild,v 1.4 2010/06/21 15:53:41 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-runtime"
KMMODULE="kde-menu"
inherit kde4-meta

DESCRIPTION="KDE Menu query tool."
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="debug"

add_blocker kde-menu
