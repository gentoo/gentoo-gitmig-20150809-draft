# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/realplayer/realplayer-8-r2.ebuild,v 1.11 2003/09/10 05:00:46 msterret Exp $

S=${WORKDIR}/usr
DESCRIPTION="Real Player 8 basic"
SRC_URI="rp8_linux20_libc6_i386_cs2_rpm"
HOMEPAGE="http://forms.real.com/real/player/unix/unix.html"

DEPEND="app-arch/rpm2targz"
RDEPEND="virtual/x11"
RESTRICT="fetch"

LICENSE="realplayer8"
SLOT="0"
KEYWORDS="x86 -ppc -sparc "

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
	rpm2targz ${DISTDIR}/${A}
	tar zxf ${WORKDIR}/${A}.tar.gz
}

src_install () {

	insinto /opt/RealPlayer8/Codecs
	doins lib/RealPlayer8/Codecs/*
	insinto /opt/RealPlayer8/Common
	doins lib/RealPlayer8/Common/*
	insinto /opt/RealPlayer8/Plugins
	doins lib/RealPlayer8/Plugins/*
	insinto /opt/RealPlayer8/Plugins/netscape
	doins lib/netscape/plugins/*
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

	dodir /opt/netscape/plugins
	for x in raclass.zip rpnp.so
	do
		dosym /opt/RealPlayer8/Plugins/netscape/${x} \
			/opt/netscape/plugins/${x}
	done

	if [ "`use mozilla`" ]
	then
		dodir /usr/lib/mozilla/plugins
		for x in raclass.zip rpnp.so
		do
			dosym /opt/RealPlayer8/Plugins/netscape/${x} \
				/usr/lib/mozilla/plugins/${x}
		done
	fi
}

