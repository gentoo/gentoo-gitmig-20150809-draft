# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.6 2002/05/07 03:58:19 drobbins Exp

# Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}.  S will get a default setting of ${WORKDIR}/${P}
# if you omit this line.

# Miller Puckette uses nonstandard versioning scheme that we have to crunch
PD_VER=`echo ${PV} | sed 's:_pre:-test:'`
S=${WORKDIR}/${PN}-${PD_VER}
DESCRIPTION="real-time music and multimedia environment"
SRC_URI="http://www-crca.ucsd.edu/~msp/Software/${PN}-${PD_VER}.linux.tar.gz"
HOMEPAGE="http://www-crca.ucsd.edu/~msp/software.html"
LICENSE=""

#
# need to do something with alsa here:
# pd can be configured to use alsa-0.5x or alsa-0.9x,
# but i don't know how to determine which one is installed
# automagicly
#
DEPEND=">=dev-lang/tcl-8.3.3
		>=dev-lang/tk-8.3.3"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S} || die
	patch -p1 < ${FILESDIR}/${PN}-${PD_VER}-gentoo.patch || die
	cd src || die
	autoconf || die
}

src_compile() {

	cd src
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	cd src
	make DESTDIR=${D} install || die
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die
}
