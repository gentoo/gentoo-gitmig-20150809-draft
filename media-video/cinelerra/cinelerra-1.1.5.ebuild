# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cinelerra/cinelerra-1.1.5.ebuild,v 1.11 2005/03/21 07:29:04 mr_bones_ Exp $

inherit gcc eutils
export WANT_GCC_3="yes"

export CFLAGS=${CFLAGS/-O?/-O2}

DESCRIPTION="Cinelerra - Professional Video Editor"
HOMEPAGE="http://heroinewarrior.com/cinelerra.php3"
SRC_URI="mirror://sourceforge/heroines/${P}-src.tar.bz2
		mirror://gentoo/${PN}-fixes-${PV}.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/x11
	virtual/libc
	=sys-devel/gcc-3*
	>=media-libs/a52dec-0.7.3"

#S=${WORKDIR}/hvirtual-${PV}

src_unpack() {
	unpack ${A}
	epatch ${DISTDIR}/${PN}-fixes-${PV}.diff.bz2

}

src_compile() {
	export ${CFLAGS}
	make || die "make failed"
}

src_install() {
	cd ${S}/${PN}/i686

	dobin ${PN}

	cd ${S}/plugins
	insinto /usr/lib/${PN}
	doins i686/*.plugin
	insinto /usr/lib/${PN}/fonts
	doins titler/fonts/*

	cd ${S}/libmpeg3/i686
	dobin mpeg3dump mpeg3cat mpeg3toc

#	cd ${S}/mix/i686
#	dobin mix2000

#	cd ${S}/xmovie/i686
#	dobin xmovie

	cd ${S}/mplexhi/i686
	dobin mplexhi

	cd ${S}/mplexlo/i686
	dobin mplexlo

	cd ${S}
#	dodoc CVS COPYING
	dohtml -a png,html,texi,sdw -r doc/*
}
