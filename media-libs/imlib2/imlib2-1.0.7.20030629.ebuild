# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib2/imlib2-1.0.7.20030629.ebuild,v 1.1 2003/06/29 17:27:29 vapier Exp $

inherit enlightenment flag-o-matic

DESCRIPTION="Version 2 of an advanced replacement library for libraries like libXpm"
HOMEPAGE="http://www.enlightenment.org/pages/imlib2.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~alpha ~mips ~arm ~hppa ~sparc"
IUSE="${IUSE} mmx gif png jpeg tiff static X"

DEPEND="${DEPEND}
	=media-libs/freetype-1*
	gif? ( media-libs/libungif
		>=media-libs/giflib-4.1.0 )
	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( media-libs/jpeg )
	tiff? ( >=media-libs/tiff-3.5.5 )"

S=${WORKDIR}/${PN}

replace-flags k6-3 i586
replace-flags k6-2 i586
replace-flags k6 i586
[ ${ARCH} = alpha ] && append-flags -fPIC

src_compile() {
	cp autogen.sh{,.old}
	sed -e 's:.*configure.*::' autogen.sh.old > autogen.sh
	env USER=blah WANT_AUTOCONF_2_5=1 ./autogen.sh || die "could not autogen"
	cd libltdl
	env WANT_AUTOCONF_2_5=1 autoconf || die
	cd ${S}

	econf \
		`use_enable mmx` \
		`use_with X x` \
		--sysconfdir=/etc/X11/imlib \
		|| die "could not configure"
	emake || die "could not make"
}

src_install() {
	make prefix=${D}/usr sysconfdir=${D}/etc/X11/imlib install || die
	dodoc AUTHORS ChangeLog README TODO
	dohtml -r doc
	docinto samples
	dodoc demo/*.c
}
