# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@gentoo.org> 
# /home/cvsroot/gentoo-x86/app-misc/xlockmore/xlockmore-5.01.2-r1.ebuild,v 1.1 2001/10/06 15:30:15 danarmak Exp

S=${WORKDIR}/${P}
DESCRIPTION="Just another screensaver application for X"
SRC_URI="ftp://ftp.tux.org/pub/tux/bagleyd/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.tux.org/~bagleyd/xlockmore.html"

DEPEND="virtual/glibc virtual/x11 pam? ( >=sys-libs/pam-0.75-r1 ) gtk? ( >=x11-libs/gtk+-1.2.10-r4 ) motif? ( >=x11-libs/openmotif-2.1.30-r1 ) esd? ( >=media-sound/esound-0.2.23 ) nas? ( >=media-sound/nas-1.4.1 ) opengl? ( virtual/opengl virtual/glu )"

src_compile() {
	local myconf
	use pam && myconf="${myconf} --enable-pam"
	use gtk || myconf="${myconf} --without-gtk"
	use motif || myconf="${myconf} --without-motif"
	use nas || myconf="${myconf} --without-nas"
	use esd || myconf="${myconf} --without-esound"
	use opengl || myconf="${myconf} --without-opengl --without-mesa"
	./configure --host=${CHOST} --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man ${myconf} || die
	emake || die
	if [ "`use gtk`" ]; then
		emake -C xglock xglock || die
	fi
	if [ "`use motif`" ]; then
		emake -C xmlock xmlock || die
	fi
}

src_install() {
	dobin xlock/xlock
	newman xlock/xlock.man xlock.1
	insinto /etc/X11/app-defaults
	newins xlock/XLock.ad XLock
	newins xlock/XLock-jp.ad XLock-jp
	dodoc docs/* README
	if [ "`use gtk`" ]; then
		dobin xglock/xglock
		dodoc xglock/README.xglock
		insinto /usr/share/xlock
		doins xglock/xglockrc
	fi
	if [ "`use motif`" ]; then
		dobin xmlock/xmlock
		insinto /etc/X11/app-defaults
		newins xmlock/XmLock.ad XmLock
		newins xmlock/XmLock-jp.ad XmLock-jp
	fi
}
