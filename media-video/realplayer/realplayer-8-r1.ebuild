# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/realplayer/realplayer-8-r1.ebuild,v 1.2 2001/10/20 02:51:28 lordjoe Exp $

P=rp8_linux20_libc6_i386_cs2_rpm
A=rp8_linux20_libc6_i386_cs2_rpm
S=${WORKDIR}/usr
DESCRIPTION="Real Player * basic"
SRC_URI=""
HOMEPAGE="http://"

DEPEND=">=app-arch/rpm-3.0.6"
RDEPEND="virtual/x11"

dyn_fetch() {
	for y in ${A} 
	do
		digest_check ${y}
			if [ $? -ne 0 ]; then
				einfo "Please download this yourself from www.real.com"
   			einfo "and place it in ${DISTDIR}"
				exit 1
			fi
	done
}

src_unpack() {
# You must download rp8_linux20_libc6_i386_cs2_rpm 
# from real.com and put it in ${DISTDIR}

  rpm2cpio ${DISTDIR}/${P} | cpio -i --make-directories

}

src_compile() {

    einfo  "A binary package, nothing to compile"

}

src_install () {

	insinto /opt/netscape/plugins
	doins lib/netscape/plugins/*
	insinto /opt/RealPlayer8/Codecs
        doins lib/RealPlayer8/Codecs/*
	insinto /opt/RealPlayer8/Common
	doins lib/RealPlayer8/Common/*
	insinto /opt/RealPlayer8/Plugins
	doins lib/RealPlayer8/Plugins/*
	insinto /opt/RealPlayer8/
	doins lib/RealPlayer8/*.xpm
	doins lib/RealPlayer8/*.rm
	doins lib/RealPlayer8/rpminstalled
	doins lib/RealPlayer8/LICENSE
	exeinto /opt/RealPlayer8
	doexe lib/RealPlayer8/*.sh
	doexe lib/RealPlayer8/realplay
	#cd ${D}/lib/netscape/plugins
	#unzip raclass.zip
	#rm raclass.zip
	insinto /etc/env.d
	doins ${FILESDIR}/10realplayer	
}

