# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/snes9x/snes9x-1.39-r1.ebuild,v 1.3 2004/02/03 21:47:15 mr_bones_ Exp $

DESCRIPTION="Super Nintendo Entertainment System (SNES) emulator"
HOMEPAGE="http://www.snes9x.com/"
SRC_URI="http://www.snes9x.com/zips/s9xs${PV/.}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="X svga 3dfx opengl"

DEPEND="x86? ( dev-lang/nasm )
	X? ( virtual/x11 )
	svga? ( media-libs/svgalib )
	opengl? ( virtual/opengl )
	3dfx? ( media-libs/glide-v3 )"
RDEPEND="X? ( virtual/x11 )
	svga? ( media-libs/svgalib )
	opengl? ( virtual/opengl )
	3dfx? ( media-libs/glide-v3 )"

S="${WORKDIR}/release"

pkg_setup() {
	local mydisp
	mydisp="`use X``use svga``use opengl``use 3dfx`"
	if [ -z "${mydisp}" ] ; then
		eerror "Unable to find a display mode"
		echo
		eerror "You must have at least 1 of the following"
		eerror "in your USE variable:"
		eerror "X   svga   opengl   3dfx"
		die "unable to compile targets"
	fi
}

src_compile() {
	patch -p1 < ${FILESDIR}/snes9x-gcc3.diff
	if [ `use ppc` ]; then
		patch -p1 < ${FILESDIR}/snes9x-139-r1-Makefile-ppc.diff
		patch -p1 < ${FILESDIR}/snes9x-139-r1-BE-sound-fix.diff
	fi

	#install our custom CXXFLAGS
	mv Makefile.linux Makefile
	cp Makefile Makefile.old
	sed -e "s:OPTIMISE=:OPTIMISE=${CXXFLAGS}:" \
		Makefile.old > Makefile

	use X			&& emake snes9x
	[ -x ${S}/snes9x ]	|| die "unable to compile for X"

	use svga		&& emake ssnes9x
	[ -x ${S}/snes9x ]	|| die "unable to compile for svga"

	use opengl		&& emake osnes9x
	[ -x ${S}/snes9x ]	|| die "unable to compile for opengl"

	use 3dfx		&& emake gsnes9x
	[ -x ${S}/snes9x ]	|| die "unable to compile for glide"
}

src_install() {
	use X		&&	dobin snes9x
	use svga	&&	dobin ssnes9x
	use opengl	&&	dobin osnes9x
	use 3dfx	&&	dobin gsnes9x
	dodoc {COPYRIGHT,CHANGES,README,PROBLEMS,TODO,HARDWARE,HOW2PORT}.TXT
}
