# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-0.5.10.ebuild,v 1.3 2001/06/10 05:12:25 drobbins Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Advanced Linux Sound Architecture / Utils"
SRC_URI="ftp://ftp.alsa-project.org/pub/utils/"${A}
HOMEPAGE="http://www.alsa-project.org/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	>=media-libs/alsa-lib-0.5.10"


src_compile() {
	try ./configure --host=${CHOST} --prefix=/usr
	try make
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
	insinto /etc/rc.d/init.d
	insopts -m0755
	doins ${FILESDIR}/alsa
}

pkg_postinst() {
	#this will configure alsa to restore and save settings correctly
	${ROOT}/usr/sbin/rc-update add alsa	
}


