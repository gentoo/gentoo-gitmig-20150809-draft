# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/quota/quota-3.03.ebuild,v 1.5 2002/07/14 19:20:19 aliz Exp $

S=${WORKDIR}/quota-tools
DESCRIPTION="Linux quota tools"
SRC_URI="mirror://sourceforge/linuxquota/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/linuxquota/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

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
