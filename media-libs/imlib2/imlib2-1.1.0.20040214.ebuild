# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib2/imlib2-1.1.0.20040214.ebuild,v 1.3 2004/02/20 10:30:12 mr_bones_ Exp $

inherit enlightenment flag-o-matic gcc

DESCRIPTION="Version 2 of an advanced replacement library for libraries like libXpm"
HOMEPAGE="http://www.enlightenment.org/pages/imlib2.html"
#SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc alpha ~hppa ~sparc amd64 ia64"
IUSE="${IUSE} mmx gif png jpeg tiff static X"

DEPEND="=media-libs/freetype-2*
	gif? ( media-libs/libungif
		>=media-libs/giflib-4.1.0 )
	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( media-libs/jpeg )
	tiff? ( >=media-libs/tiff-3.5.5 )
	X? ( virtual/x11 )"

S=${WORKDIR}/${PN}		# cvs
#S=${WORKDIR}/${P}		# release

src_compile() {
	replace-flags k6-3 i586
	replace-flags k6-2 i586
	replace-flags k6 i586

	[ "${ARCH}" = "amd64" ] && append-flags -fPIC

	if [ "${S}" == "${WORKDIR}/${PN}" ] ; then
		# cvs only stuff

		# uhh, assumes x86 asm for mmx, doesn't work on amd64
		if [ "${ARCH}" = "amd64" ]
		then
			mmx="--disable-mmx"
		else
			mmx=`use_enable mmx`
		fi

		export MY_ECONF="
			${mmx} \
			`use_with X x` \
			--sysconfdir=/etc/X11/imlib
		"
		EHACKAUTOGEN=yes
		EHACKLIBLTDL=yes
		enlightenment_src_compile
	else
		econf \
			`use_enable mmx` \
			`use_with X x` \
			--sysconfdir=/etc/X11/imlib \
			|| die "could not configure"
		emake || die "could not make"
	fi
}

src_install() {
	make prefix=${D}/usr sysconfdir=${D}/etc/X11/imlib install || die
	dodoc AUTHORS ChangeLog README TODO
	dohtml -r doc
	docinto samples
	dodoc demo/*.c
}
