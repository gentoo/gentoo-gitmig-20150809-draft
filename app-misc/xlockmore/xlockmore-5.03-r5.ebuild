# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: system@gentoo.org
# $Header: /var/cvsroot/gentoo-x86/app-misc/xlockmore/xlockmore-5.03-r5.ebuild,v 1.4 2002/06/03 21:55:30 lostlogic Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Just another screensaver application for X"
SRC_URI="ftp://ftp.tux.org/pub/tux/bagleyd/xlockmore/${P}.tar.gz"
HOMEPAGE="http://www.tux.org/~bagleyd/xlockmore.html"

DEPEND="virtual/x11 media-libs/freetype
	opengl? ( virtual/opengl )
	pam? ( sys-libs/pam )
	nas? ( media-libs/nas )
	esd? ( media-sound/esound )"
	# motif? ( >=x11-libs/openmotif-2.1.30-r1 )
	# gtk? ( x11-libs/gtk+ )

src_compile() {
	local myconf
	use pam && myconf="${myconf} --enable-pam" \
		|| myconf="${myconf} --disable-pam --enable-xlockrc"
	use nas || myconf="${myconf} --without-nas"
	use esd && myconf="${myconf} --with-esound"
	use opengl || myconf="${myconf} --without-opengl --without-gltt --without-mesa"
	use truetype || myconf="${myconf} --without-ttf"

	#use motif || myconf="${myconf} --without-motif"
	#use gtk || myconf="${myconf} --without-gtk"
	# sigh... broken configure script and/or makefile...
	myconf="${myconf} --without-motif --without-gtk"

	./configure \
		--prefix=/usr \
		--mandir=${prefix}/share/man/man1 \
		--sharedstatedir=/usr/share/xlockmore \
		--host=${CHOST} ${myconf} || die

	#xlock resets to -j1
	make || die

	# configure script seems to suffer braindamage and doesn't setup
	# correct makefiles for these, so they are disabled for now until
	# some kind soul wants to submit a patch ;)

	#if [ "`use gtk`" ] ; then
	#	cd ${S}/xglock
	#	make all || die
	#fi

	#if [ "`use motif`" ] ; then
	#	cd ${S}/xmlock
	#	make all || die
	#fi
}

src_install() {
	make install \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man/man1 \
		xapploaddir=${D}/usr/X11R6/lib/X11/app-defaults || die

	#Install pam.d file and unset setuid root 
	if use pam; then
		insinto /etc/pam.d
		newins etc/xlock.pamd xlock
		chmod 111 ${D}/usr/bin/xlock
	fi

	insinto /usr/share/xlockmore/sounds
	doins sounds/*

#	use motif && doexe ${S}/xmlock/xmlock 
#	use gtk && doexe ${S}/xglock/xglock

	dodoc docs/* README 
	dohtml docs/*.html
	rm ${D}/usr/share/doc/${PF}/*.html.gz
#	use gtk && dodoc xglock/xglockrc xglock/README.xglock
}
