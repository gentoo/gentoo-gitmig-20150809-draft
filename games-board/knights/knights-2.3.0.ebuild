# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/knights/knights-2.3.0.ebuild,v 1.2 2011/04/20 20:30:22 scarabeus Exp $

EAPI=4

KDE_LINGUAS="cs da de en_GB eo es et fi fr hu it ja lt ml nds nl pl pt_BR ro ru
sk sr sv uk zh_TW"
inherit kde4-base

DESCRIPTION="A simple chess board for KDE"
HOMEPAGE="http://kde-apps.org/content/show.php/Knights?content=122046"
SRC_URI="http://dl.dropbox.com/u/2888238/Knights/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="amd64 x86"
SLOT="4"
IUSE="debug +handbook"

DEPEND="$(add_kdebase_dep libkdegames)"
RDEPEND="${DEPEND}"
