# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/hugs98/hugs98-2003.11.ebuild,v 1.8 2004/11/16 12:23:28 kosmikus Exp $

inherit base flag-o-matic eutils

IUSE="opengl"

MY_P="hugs98-Nov2003"
S=${WORKDIR}/${MY_P}
DESCRIPTION="The HUGS98 Haskell interpreter"
SRC_URI="http://cvs.haskell.org/Hugs/downloads/Nov2003/${MY_P}.tar.gz"
HOMEPAGE="http://www.haskell.org/hugs/"

SLOT="0"
KEYWORDS="x86 ~sparc ~amd64"
LICENSE="as-is"

DEPEND="virtual/libc
	opengl? ( virtual/opengl virtual/glu virtual/glut )
	~app-text/docbook-sgml-dtd-4.2"

src_unpack() {
	base_src_unpack
	cd ${S}/src
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_compile() {
	local myconf

	[ "${ARCH}" = "amd64" ] && append-flags -fPIC

	if use opengl; then
		myconf="--enable-hopengl"
		# the nvidia drivers *seem* not to work together
		# with pthreads
		[ ! -f /etc/env.d/09opengl ] \
			|| [ -z "`grep opengl/nvidia/lib /etc/env.d/09opengl`" ] \
			&& myconf="$myconf --with-pthreads" \
			|| myconf="--with-pthreads"
	fi

	# When timing is enabled, the build will fail at some
	# point with:
	#
	#  | gcc runhugs.o server.o [...]-o runhugs
	#  | evaluator.o(.text+0x1b7): In function `evaluator':
	#  | : undefined reference to `updateTimers'
	#  | collect2: ld returned 1 exit status
	#
	# Somebody *cough* should look into this.

	myconf="$myconf --disable-timer"

	# When using econf here, configure will spout warnings
	# about how you need to give "--host --target --build",
	# and sometimes it will refuse to run at all.

	cd ${S}/src/unix || die "source directory not found"
	./configure \
		--host=${CHOST} \
		--target=${CHOST} \
		--build=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-ffi \
		--with-pthreads \
		--enable-profiling \
		${myconf} || die "./configure failed"
	cd ..
	emake || die "make failed"
}

src_install () {
	cd ${S}/src || die "source directory not found"
	make \
		HUGSDIR=${D}/usr/lib/hugs \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "make install failed"

	#somewhat clean-up installation of few docs
	cd ${S}
	dodoc Credits License Readme
	cd ${D}/usr/lib/hugs
	rm Credits License Readme
	mv demos/ docs/ ${D}/usr/share/doc/${PF}
}
