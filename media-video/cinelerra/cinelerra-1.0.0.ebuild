# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cinelerra/cinelerra-1.0.0.ebuild,v 1.8 2003/09/07 00:08:12 msterret Exp $

inherit gcc
export WANT_GCC_3="yes"

DESCRIPTION="Cinelerra - Professional Video Editor"
HOMEPAGE="http://heroinewarrior.com/cinelerra.php3"
SRC_URI="mirror://sourceforge/heroines/hvirtual-${PV}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11
	virtual/glibc
	=sys-devel/gcc-3*"

S=${WORKDIR}/hvirtual-${PV}

src_compile() {
	echo ${CFLAGS} > i686/c_flags
	make || die "make failed"
}

src_install() {
	cd ${S}/${PN}/i686

	dobin ${PN}

	cd ${S}/plugins
	insinto /usr/lib/${PN}
	doins i686/*.plugin
	doins titler/fonts

	cd ${S}/libmpeg3/i686
	dobin mpeg3dump mpeg3cat mpeg3toc

	cd ${S}/mix/i686
	dobin mix2000

	cd ${S}/xmovie/i686
	dobin xmovie

	cd ${S}/mplexhi/i686
	dobin mplexhi

	cd ${S}/mplexlo/i686
	dobin mplexlo

	cd ${S}
	dodoc CVS COPYING
	dohtml -a png,html,texi,sdw -r doc/*
}
