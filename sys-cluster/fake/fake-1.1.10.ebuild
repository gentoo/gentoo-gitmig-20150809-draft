# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/fake/fake-1.1.10.ebuild,v 1.1 2005/11/17 02:05:23 xmerlin Exp $

DESCRIPTION="Fake has been designed to switch in backup servers on a LAN."
SRC_URI="http://www.vergenet.net/linux/${PN}/download/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.vergenet.net/linux/fake/"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"
IUSE=""

DEPEND=""

src_compile(){
	make patch || die "building patch failed"
	emake || die "make failed"
}

src_install(){
	make ROOT_DIR=${D} install || die "install failed"
	dodoc AUTHORS ChangeLog COPYING README docs/*
}
