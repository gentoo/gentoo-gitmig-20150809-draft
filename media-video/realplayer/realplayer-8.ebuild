# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/realplayer/realplayer-8.ebuild,v 1.1 2001/06/21 22:09:53 lamer Exp $

P=rp8_linux20_libc6_i386_cs2_rpm
A=rp8_linux20_libc6_i386_cs2_rpm
S=${WORKDIR}/usr
DESCRIPTION="Real Plaeyer * basic"
SRC_URI=""
HOMEPAGE="http://"

DEPEND=">=app-arch/rpm-3.0.6"
src_unpack() {
# You must download rp8_linux20_libc6_i386_cs2_rpm 
# from real.com and put it in ${DISTDIR}

  rpm2cpio ${DISTDIR}/${P} > rp8.cpio
  cpio -i --make-directories < rp8.cpio

}

src_compile() {

    echo -n "Only binary package, nothing to compile"

}

src_install () {

	insinto /opt/netscape/plugins
	doins lib/netscape/*
	insinto /usr/lib/RealPlayer8/Codecs
        doins lib/RealPlayer8/Codecs/*
	insinto /usr/lib/RealPlayer8/Common
	doins lib/RealPlayer8/Common/*
	insinto /usr/lib/RealPlayer8/Plugins
	doins lib/RealPlayer8/Plugins/*
	insinto /usr/lib/RealPlayer8/
	doins lib/RealPlayer8/*.xpm
	doins lib/RealPlayer8/*.rm
	doins lib/RealPlayer8/rpminstalled
	doins lib/RealPlayer8/LICENSE
	exeinto /usr/lib/RealPlayer8
	doexe lib/RealPlayer8/*.sh
	doexe lib/RealPlayer8/realplay
	dodir /opt/kde2.1/share
	insinto /opt/kde2.1/share/ 
	doins share/*
	dodir /usr/bin
	dosym /usr/lib/RealPlayer8/realplay /usr/bin/realplay
}

