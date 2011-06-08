# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmousetool/kmousetool-4.6.3.ebuild,v 1.2 2011/06/08 22:46:38 tomka Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdeaccessibility"

inherit kde4-meta

DESCRIPTION="KDE program that clicks the mouse for you."
KEYWORDS="~amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep knotify)
"
