# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Aron Griffis <agriffis@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/quota/quota-3.04.ebuild,v 1.2 2002/04/27 23:34:20 bangert Exp $

S=${WORKDIR}/quota-tools
DESCRIPTION="Linux quota tools"
SRC_URI="http://prdownloads.sourceforge.net/linuxquota/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/linuxquota/"

DEPEND="virtual/glibc"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	mkdir -p ${D}/{sbin,etc,usr/sbin,usr/bin,usr/share/man/man{1,2,3,8}}
	make ROOTDIR=${D} install || die
	install -m 644 warnquota.conf ${D}/etc
	dodoc doc/*
}
