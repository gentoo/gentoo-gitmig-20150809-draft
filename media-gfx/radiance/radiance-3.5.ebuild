# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/radiance/radiance-3.5.ebuild,v 1.4 2004/03/23 19:19:08 mholzer Exp $

MY_P=${P/./R}
MY_P=${MY_P/radiance-/rad}

IUSE="X"

DESCRIPTION="Radiance is a suite of programs for the analysis and visualization of lighting in design"
HOMEPAGE="http://radsite.lbl.gov/radiance/"
SRC_URI="http://radsite.lbl.gov/${PN}/dist/$MY_P.tar.gz"

LICENSE="Radiance"
SLOT="0"
KEYWORDS="~x86"

DEPEND="media-libs/tiff
	app-shells/tcsh
	X? ( virtual/x11 dev-lang/tk )"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/ray
	mkdir -p src/lib

	use X ||  epatch ${FILESDIR}/${P}-noX11.patch

	# patch to not build libtiff that comes with Radiance
	cp src/px/Rmakefile src/px/Rmakefile.orig
	sed -e "s/\.\.\/lib\/libtiff\.a$//g" \
		src/px/Rmakefile.orig > src/px/Rmakefile

	# fix syntax error in standard.h
	cp src/common/standard.h src/common/standard.h.orig
	sed -e "s/error(et,em) else$/error(et,em); else/g" \
		src/common/standard.h.orig > src/common/standard.h

	# fix incorrect use of errno.h
	cp src/cal/ev.c src/cal/ev.c.orig
	sed -e "s/extern int  errno;/#include <errno.h>/g" \
		src/cal/ev.c.orig > src/cal/ev.c
}

src_compile() {
	mkdir -p ${T}/bin
	mkdir -p ${T}/bin/dev
	mkdir -p ${T}/lib/ray

	cd ${WORKDIR}/ray/src
	local srcdirs="common meta cv gen ot rt px hd util cal"
	for i in $srcdirs ;
	do
		pushd $i
		make "SPECIAL=" \
			"OPT=$CFLAGS -DSPEED=200" \
			"MACH=-Dlinux -L/usr/X11R6/lib -I/usr/include/X11 -DNOSTEREO -DBIGMEM" \
			ARCH=IBMPC "COMPAT=bmalloc.o erf.o getpagesize.o" \
			INSTDIR=${T}/bin \
			LIBDIR=${T}/lib/ray \
			CC=gcc "$@" -f Rmakefile install || die "Unable to build $i"
		popd
	done

	# TODO: figure out what to do with the dev files
	mv ${T}/bin/dev ${T}/dev

	rm -r ${WORKDIR}/ray/lib/CVS
	rm -r ${T}/lib/ray/CVS
	rm -r ${WORKDIR}/ray/doc/notes/CVS
}

src_install() {
	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/lib/ray

	dobin ${T}/bin/*

	cp -R ${T}/lib/ray ${D}/usr/lib/ray
	cd ${WORKDIR}/ray
	(cd lib ; tar -cf - *) | (cd ${D}/usr/lib/ray ; tar -xf -)

	# man = /usr/share/man
	cd ${WORKDIR}/ray
	doman doc/man/man1/*.1
	doman doc/ray.1
	doman doc/man/man3/*.3
	doman doc/man/man5/*.5
	prepallman

	dodoc README

	docinto notes
	dodoc doc/notes/*

	docinto pdf
	dodoc doc/pdf/*.pdf
	dodoc doc/ps/*.ps
	dohtml doc/ray.html
	prepalldocs
}
