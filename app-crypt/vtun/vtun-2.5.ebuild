# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/vtun/vtun-2.5.ebuild,v 1.1 2002/05/23 21:53:27 prez Exp $

DESCRIPTION="Tunneling software to use the universal tunnel"
HOMEPAGE="http://vtun.sourceforge.net"
LICENSE="GPL-2"
DEPEND=">=sys-libs/zlib-1.1.4
	>=dev-libs/lzo-1.07
	>=dev-libs/openssl-0.9.6c-r1
	>=sys-kernel/linux-headers-2.4.18"
#RDEPEND=""
SRC_URI="ftp://prdownloads.sourceforge.net/vtun/${P}.tar.gz"
S=${WORKDIR}/vtun

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	mv config.h config.h.orig
	mv cfg_file.y cfg_file.y.orig
	mv auth.c auth.c.orig
	mv lfd_encrypt.c lfd_encrypt.c.orig
	sed "s,/* #undef HAVE_LINUX_IF_TUN_H */,#define HAVE_LINUX_IF_TUN_H 1," \
		config.h.orig >config.h
	sed "s,expect 18,expect 20," \
		cfg_file.y.orig >cfg_file.y
	sed "s,#include <md5.h>,#include <md5global.h>\n#include <md5.h>," \
		auth.c.orig >auth.c
	sed "s,#include <md5.h>,#include <md5global.h>\n#include <md5.h>," \
		lfd_encrypt.c.orig >lfd_encrypt.c
	emake \
		ETC_DIR=/etc \
		VAR_DIR=/var || die
}

src_install () {
	make \
		prefix=${D}/usr \
		ETC_DIR=${D}/etc \
		VAR_DIR=${D}/var \
		INFO_DIR=${D}/usr/share/info \
		MAN_DIR=${D}/usr/share/man install || die
	dodoc ChangeLog FAQ README* TODO vtund.conf
}
