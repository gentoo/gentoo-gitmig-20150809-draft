# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/klibido/klibido-0.2.0-r1.ebuild,v 1.1 2005/02/17 02:14:38 swegener Exp $

inherit kde eutils

DESCRIPTION="KDE Linux Binaries Downloader"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://klibido.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/uulib
	=sys-libs/db-4.1*"

need-kde 3

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/0.2.0-nntpthreadsocket.cpp.diff
	epatch ${FILESDIR}/0.2.0-qmgr.cpp.diff
}

src_compile() {
	myconf="${myconf} --datadir=${D}/usr/share --with-extra-includes=/usr/include/db4.1/"
	kde_src_compile
}
