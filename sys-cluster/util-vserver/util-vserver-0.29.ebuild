# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/util-vserver/util-vserver-0.29.ebuild,v 1.1 2004/03/25 12:25:10 tantive Exp $

DESCRIPTION="Util-Vserver s_context Management utilities"
HOMEPAGE="http://savannah.nongnu.org/projects/util-vserver/"
SRC_URI="http://www-user.tu-chemnitz.de/~ensc/util-vserver/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="nomirror"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/configure.patch
	automake
	autoconf
}

src_compile() {
	# don't use costum cflags
	unset CFLAGS CXXFLAGS
	./configure \
		--host=${CHOST} \
		--exec-prefix=/usr \
		--prefix=/ \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postint() {
	cd ${D}
	for i in `find ./etc -name "v_*"`;do rm $i;done
}
