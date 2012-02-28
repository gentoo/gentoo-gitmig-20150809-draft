# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/kwooty/kwooty-0.8.2.ebuild,v 1.1 2012/02/28 19:42:52 johu Exp $

EAPI=4

KDE_LINGUAS="cs de fr"
inherit kde4-base

DESCRIPTION="Friendly nzb linux usenet binary client"
HOMEPAGE="http://sourceforge.net/projects/kwooty/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep solid)"
RDEPEND="${DEPEND}
	app-arch/unrar
	app-arch/par2cmdline"

DOCS=( README.txt TODO )

src_prepare() {
	sed -i \
		-e 's:${KDE4WORKSPACE_SOLIDCONTROL_LIBS}:solidcontrol:' \
		src/CMakeLists.txt || die
	kde4-base_src_prepare
}
