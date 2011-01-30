# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/kwooty/kwooty-0.6.2.ebuild,v 1.2 2011/01/30 18:35:12 scarabeus Exp $

EAPI=3
inherit kde4-base

DESCRIPTION="A friendly nzb linux usenet binary client"
HOMEPAGE="http://sourceforge.net/projects/kwooty/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep solid)"
RDEPEND="${DEPEND}
	app-arch/unrar
	app-arch/par2cmdline"

DOCS="README.txt"

src_prepare() {
	sed -i \
		-e 's:${KDE4WORKSPACE_SOLIDCONTROL_LIBS}:solidcontrol:' \
		src/CMakeLists.txt || die
	kde4-base_src_prepare
}
