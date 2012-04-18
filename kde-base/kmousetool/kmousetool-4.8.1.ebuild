# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmousetool/kmousetool-4.8.1.ebuild,v 1.3 2012/04/18 21:26:05 maekke Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"

inherit kde4-base

DESCRIPTION="KDE program that clicks the mouse for you."
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep knotify)
"
