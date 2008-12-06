# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/fake/fake-1.1.10.ebuild,v 1.5 2008/12/06 18:01:04 xmerlin Exp $

DESCRIPTION="Fake has been designed to switch in backup servers on a LAN."
SRC_URI="http://www.vergenet.net/linux/${PN}/download/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.vergenet.net/linux/fake/"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"
IUSE=""

DEPEND=""

src_compile(){
	make patch || die "patching failed"
	emake || die "make failed"
}

src_install(){
	emake \
		ROOT_DIR="${D}" \
		MAN8_DIR="${D}/usr/share/man/man8" \
		DOC_DIR="${D}/usr/share/doc/${P}" \
		install || die "install failed"
	dodoc AUTHORS ChangeLog COPYING README docs/*
}
