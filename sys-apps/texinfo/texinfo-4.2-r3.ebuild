# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/texinfo/texinfo-4.2-r3.ebuild,v 1.1 2002/06/28 01:33:48 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The GNU info program and utilities"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/texinfo/${P}.tar.gz
	ftp://ftp.gnu.org/pub/gnu/texinfo/${P}.tar.gz"

SLOT=""
LICENSE="GPL-2"

if [ "`use build`" ] ; then
	DEPEND="virtual/glibc"
else
	DEPEND="virtual/glibc 
		>=sys-libs/ncurses-5.2-r2
		>=sys-devel/automake-1.6
		nls? ( sys-devel/gettext )"
	RDEPEND="virtual/glibc 
		>=sys-libs/ncurses-5.2-r2"
fi

src_compile() {
	export WANT_AUTOMAKE_1_6=1
	local myconf
	if [ -z "`use nls`" ] || [ "`use build`" ] ; then
		myconf="--disable-nls"
	fi
	./configure --host=${CHOST} --prefix=/usr  ${myconf} \
		--mandir=/usr/share/man --infodir=/usr/share/info || die
	make ${MAKEOPTS} || die 
}

src_install() {
	if [ "`use build`" ] ; then
		dobin makeinfo/makeinfo util/{install-info,texi2dvi,texindex}
	else
		make DESTDIR=${D} infodir=/usr/share/info install || die
		exeinto /usr/sbin
		doexe ${FILESDIR}/mkinfodir

		cd ${D}/usr/share/info
		mv texinfo texinfo.info
		for i in texinfo-*
		do
			mv ${i} texinfo.info-${i#texinfo-*}
		done
		cd ${S}

		dodoc AUTHORS ChangeLog COPYING INTRODUCTION NEWS README TODO 
		docinto info
		dodoc info/README
		docinto makeinfo
		dodoc makeinfo/README
	fi
}

