# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksirk/ksirk-4.6.2.ebuild,v 1.4 2011/06/01 18:52:56 ranger Exp $

EAPI=3

KDE_HANDBOOK="optional"
KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="KDE: Ksirk is a KDE port of the board game risk"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-crypt/qca:2
"
RDEPEND="${DEPEND}"
