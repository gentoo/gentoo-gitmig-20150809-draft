# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/snes9x/snes9x-139-r1.ebuild,v 1.6 2002/10/03 20:31:12 vapier Exp $

DESCRIPTION="Super Nintendo Entertainment System (SNES) emulator"
HOMEPAGE="http://www.snes9x.com/"
LICENSE="as-is"
KEYWORDS="x86 -ppc"
SLOT="0"  
SRC_URI="http://www.snes9x.com/zips/s9xs${PV}.zip"
DEPEND="dev-lang/nasm
	X? ( virtual/x11 )
	svga? ( media-libs/svgalib )
	opengl? ( virtual/opengl )
	glide? ( media-libs/glide-v3 )"
RDEPEND="${DEPEND}"
S="${WORKDIR}/release"

pkg_setup() {
	local mydisp
	mydisp="`use X``use svga``use opengl``use glide`"
	if [ -z "${mydisp}" ] ; then
		eerror "Unable to find a display mode"
		echo
		eerror "You must have at least 1 of the following"
		eerror "in your USE variable:"
		eerror "X   svga   opengl   glide"
		die "unable to compile targets"
	fi
}

src_compile() {
	patch -p1 < ${FILESDIR}/snes9x-gcc3.diff

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

	use glide		&& emake gsnes9x
	[ -x ${S}/snes9x ]	|| die "unable to compile for glide"
}

src_install() {
	use X		&&	dobin snes9x
	use svga	&&	dobin ssnes9x
	use opengl	&&	dobin osnes9x
	use glide	&&	dobin gsnes9x
	dodoc {COPYRIGHT,CHANGES,README,PROBLEMS,TODO,HARDWARE,HOW2PORT}.TXT
}
