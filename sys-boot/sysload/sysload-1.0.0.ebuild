# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/sysload/sysload-1.0.0.ebuild,v 1.1 2009/01/02 05:44:03 vapier Exp $

inherit eutils

DESCRIPTION="minimal boot loader linux system"
HOMEPAGE="http://www.ibm.com/developerworks/linux/linux390/sysload.html"
SRC_URI="http://download.boulder.ibm.com/ibmdl/pub/software/dw/linux390/ht_src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-libs/libssh-0.11"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	sed -i '/^subdirs/s:doc::' Makefile
	sed -i "s:/usr/share/doc/sysload/:/usr/share/doc/${PF}/:" admin/Makefile
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc README TODO
	prepalldocs
}
