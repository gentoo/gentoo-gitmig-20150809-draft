# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cinelerra/cinelerra-1.1.9.ebuild,v 1.1 2004/02/14 15:41:33 lu_zero Exp $

inherit gcc eutils flag-o-matic
export WANT_GCC_3="yes"

#export CFLAGS=${CFLAGS/-O?/-O2}

filter-flags "-fPIC -fforce-addr"

DESCRIPTION="Cinelerra - Professional Video Editor"
HOMEPAGE="http://heroinewarrior.com/cinelerra.php3"
SRC_URI="mirror://sourceforge/heroines/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -ppc"

DEPEND="virtual/x11
	virtual/glibc
	=sys-devel/gcc-3*
	dev-lang/nasm"
#	>=media-libs/a52dec-0.7.3"

src_unpack() {
	unpack ${A}
#	epatch ${FILESDIR}/gcc-3.3.1-collate.patch
#	epatch ${FILESDIR}/pthread_t_not_int.patch
}

src_compile() {
	export CFLAGS=${CFLAGS}
	cd ${S}/freetype-2.1.4/builds/unix
	econf ||die
	cd ${S}/quicktime/ffmpeg-0.4.8
	econf ||die

	cd ${S}
	make || die "make failed"
}

src_install() {
	local myarch
	if [ -n "`use x86`" ]; then
	myarch="${CHOST/-*/}" #should solve the i586/i686 problem
	fi
	if [ -n "`use ppc`" ]; then
	myarch="ppc"
	fi
	cd ${S}/${PN}/${myarch}
	dobin ${PN} || die "cinelerra not built"

	cd ${S}/plugins
	insinto /usr/lib/${PN}
	doins ${myarch}/*.plugin
	insinto /usr/lib/${PN}/fonts
	doins titler/fonts/*

	cd ${S}/libmpeg3/${myarch}
	dobin mpeg3dump mpeg3cat mpeg3toc

#	cd ${S}/mix/i686
#	dobin mix2000

#	cd ${S}/xmovie/i686
#	dobin xmovie

	cd ${S}/mplexhi/${myarch}
	dobin mplexhi

	cd ${S}/mplexlo/${myarch}
	dobin mplexlo

	cd ${S}
#	dodoc CVS COPYING
	dohtml -a png,html,texi,sdw -r doc/*
}
