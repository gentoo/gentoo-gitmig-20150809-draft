# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ezm3/ezm3-1.2.ebuild,v 1.4 2005/08/24 00:22:51 vapier Exp $

inherit eutils

DESCRIPTION="stripped down m3 compiler for building cvsup"
HOMEPAGE="http://www.polstra.com/projects/freeware/ezm3/"
SRC_URI="ftp://ftp.freebsd.org/pub/FreeBSD/development/CVSup/ezm3/${P}-src.tar.bz2
	x86? ( ftp://ftp.freebsd.org/pub/FreeBSD/development/CVSup/ezm3/${P}-LINUXLIBC6-boot.tar.bz2 )
	ppc? ( mirror://gentoo/${P}-PPC_LINUX-boot.tar.bz2 )
	mirror://gentoo/${P}-PPC_LINUX.patch.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* x86 ppc"
IUSE="X opengl"

DEPEND="virtual/libc
	dev-util/yacc
	>=sys-apps/sed-4
	!virtual/m3"
RDEPEND="virtual/libc"
PROVIDE="virtual/m3"

seduse() {
	useq !${1} && echo "${2}" || echo ":"
}

ezm3target() {
	case ${ARCH} in
		x86)	echo LINUXLIBC6;;
		ppc)	echo PPC_LINUX;;
	esac
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-PPC_LINUX.patch
}

src_compile() {
	# when you do make, ezm3 builds & installs at the same time so we control
	# where it is going to install the compiler and stuff
	# (to not violate sandbox)
	sed -i \
		-e "s:/usr/local:/usr:" \
		m3config/src/$(ezm3target) \
		|| die "sed $(ezm3target) failed"
	echo "M3CC_MAKE = [\"make\", \"BISON=yacc\"]" >> m3config/src/$(ezm3target)

	# now we disable X and OpenGL if the user doesnt have them in their USE var
	sed -i \
		-e "s:/usr/local:/usr:" \
	 	-e "s:touch:ranlib:" \
	 	-e "s:`seduse X 'import_X11():import_X11() is\nend\nproc dont_import_X11()'`:" \
		-e "s:`seduse opengl 'import_OpenGL():import_OpenGL() is\nend\nproc dont_import_OpenGL()'`:" \
		m3config/src/COMMON \
		|| die "sed COMMON failed"

	# finally we compile the m3 compiler
	# we clear the CFLAGS because:
	#	(1) higher optimizations cause issues
	#	(2) build system uses gcc-3.2.3 ... dont want to trigger CFLAG mismatches
	#	(3) it doesnt really matter ... we are just building cvsup ;)
	# Remove P because it's used internally ;x
	env -u P -u CFLAGS emake -j1 exportall || die "ezm3 compile failed"
}

src_install() {
	cd binaries/$(ezm3target)
	cp -pPR usr ${D}/ || die
	rm -rf ${D}/usr/man
}
