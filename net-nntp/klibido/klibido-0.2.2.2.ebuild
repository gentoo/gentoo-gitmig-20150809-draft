# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/klibido/klibido-0.2.2.2.ebuild,v 1.1 2005/03/19 00:41:22 swegener Exp $

inherit kde versionator

DESCRIPTION="KDE Linux Binaries Downloader"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://klibido.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="dev-libs/uulib
	>=sys-libs/db-4.1"

need-kde 3

src_compile() {
	local libdbver="$(best_version sys-libs/db)"
	libdbver="${libdbver/sys-libs\/db-/}"
	libdbver="$(get_version_component_range 1-2 ${libdbver})"

	myconf="${myconf} --datadir=${D}/usr/share --with-extra-includes=/usr/include/db${libdbver}/"
	kde_src_compile
}
