# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-0.5.10-r6.ebuild,v 1.1 2001/10/02 20:34:44 woodchip Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Advanced Linux Sound Architecture / Utils"
SRC_URI="ftp://ftp.alsa-project.org/pub/utils/"${A}
HOMEPAGE="http://www.alsa-project.org/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	>=media-libs/alsa-lib-0.5.10"

src_compile() {
	./configure --host=${CHOST} --prefix=/usr || die
	make || die
}

src_install() {
	cd ${S}/aplay
	cd aplay
	cp Makefile Makefile.orig
	sed -e "s:cd \$(bindir):cd \$(DESTDIR)\$(bindir):" \
	sed -e "s:cd \$(mandir):cd \$(DESTDIR)\$(mandir):" \
	Makefile.orig > Makefile
	cd ${S}
	try make DESTDIR=${D} install
	dodoc ChangeLog COPYING README
	newdoc alsamixer/README README.alsamixer
	dodoc seq/aconnect/README* seq/aseqnet/README*

	exeinto /etc/init.d
	newexe ${FILESDIR}/alsa.rc6 alsa
}

pkg_postinst() {
	:;
	#this will configure alsa to restore and save settings correctly
	#${ROOT}/usr/sbin/rc-update add alsa	
}
