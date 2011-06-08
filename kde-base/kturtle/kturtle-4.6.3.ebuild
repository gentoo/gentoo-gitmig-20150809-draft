# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kturtle/kturtle-4.6.3.ebuild,v 1.2 2011/06/08 23:17:49 tomka Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="KDE: Educational programming environment using the Logo programming language"
KEYWORDS="~amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep knotify)
"
