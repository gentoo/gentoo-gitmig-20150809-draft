# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gpm/gpm-1.19.3-r5.ebuild,v 1.1 2001/09/08 09:19:39 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Console-based mouse driver"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/mouse/${P}.tar.gz ftp://ftp.prosa.it/pub/gpm/patches/devfs.patch"
DEPEND="virtual/glibc >=sys-libs/ncurses-5.2 sys-devel/autoconf"
RDEPEND="virtual/glibc"

src_unpack() {
  	unpack ${P}.tar.gz
	cd ${S}
	cp ${FILESDIR}/gpmInt.h .
	patch -p1 < ${DISTDIR}/devfs.patch
	#this little hack turns of EMACS byte compilation.  Really don't want this thing auto-detecting emacs
	cp configure.in configure.in.orig
	sed -e '45i\' -e 'EMACS=:\' -e 'ELISP=' configure.in.orig > configure.in || die
	autoconf || die
}

src_compile() {
	./configure --prefix=/usr --sysconfdir=/etc/gpm || die
	# without-curses is required to avoid cyclic dependencies to ncurses

	cp Makefile Makefile.orig
	#The emacs stuff turns off auto byte-"complication"
	sed -e "s/doc//" Makefile.orig > Makefile
	#-e '/$(EMACS)/c\' -e '	echo' 

	emake || die
}

src_install() {
	make prefix=${D}/usr install || die
	chmod 755 ${D}/usr/lib/libgpm.so.1.18.0
	dodoc Announce COPYING ChangeLog FAQ MANIFEST README.*
	docinto txt
	dodoc doc/gpmdoc.txt

	insinto /etc/gpm
	doins gpm-root.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/gpm.rc6 gpm
}
