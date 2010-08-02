# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/kwooty/kwooty-0.5.1.ebuild,v 1.1 2010/08/02 13:08:26 ssuominen Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="A friendly nzb linux usenet binary client"
HOMEPAGE="http://sourceforge.net/projects/kwooty/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/libkworkspace-${KDE_MINIMAL}
	>=kde-base/solid-${KDE_MINIMAL}"
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
