# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/kterm/kterm-6.2.0.ebuild,v 1.2 2002/09/21 04:41:47 vapier Exp $

DESCRIPTION="Japanese Kanji X Terminal"
SRC_URI="ftp://ftp.x.org/contrib/applications/kterm-6.2.0.tar.gz"
# until someone who reads japanese can find a better place
HOMEPAGE="http://www.asahi-net.or.jp/~hc3j-tkg/kterm/"
LICENSE="X11"
SLOT=0
KEYWORDS="x86"

S=${WORKDIR}/${P}

DEPEND="virtual/glibc virtual/x11"
RDEPEND="${DEPEND}"

src_unpack(){
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/kterm-6.2.0-gentoo.patch
}

src_compile(){
	xmkmf -a || die;
	emake    || die;
}

src_install(){
	make DESTDIR=${D} install     || die;
	make DESTDIR=${D} install.man || die;

	if [ ! -e /usr/share/terminfo/k/kterm ];
	then
		cd {S};
		tic terminfo.kt -o${D}/usr/share/terminfo;
	fi
}
