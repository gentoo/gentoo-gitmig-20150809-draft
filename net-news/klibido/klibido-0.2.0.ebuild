# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/klibido/klibido-0.2.0.ebuild,v 1.1 2004/12/02 03:27:11 jhuebel Exp $

inherit kde

DESCRIPTION="KDE Linux Binaries Downloader"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://klibido.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/uulib
	sys-libs/db"

src_compile() {
	myconf="${myconf} --datadir=${D}/usr/share --with-extra-includes=/usr/include/db4.1/"
	kde_src_compile
}
