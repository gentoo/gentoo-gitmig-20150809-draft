# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib2/imlib2-1.1.0.20031108.ebuild,v 1.1 2003/11/08 19:29:33 vapier Exp $

inherit enlightenment flag-o-matic gcc

DESCRIPTION="Version 2 of an advanced replacement library for libraries like libXpm"
HOMEPAGE="http://www.enlightenment.org/pages/imlib2.html"
#SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~mips ~arm ~hppa ~sparc ~amd64"
IUSE="${IUSE} mmx gif png jpeg tiff static X"

DEPEND="${DEPEND}
	=media-libs/freetype-2*
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

	if [ "${S}" == "${WORKDIR}/${PN}" ] ; then
		# cvs only stuff
		export MY_ECONF="
			`use_enable mmx` \
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
