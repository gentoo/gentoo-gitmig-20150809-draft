# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="ted is an X-based rich text editor."
HOMEPAGE="http://www.nllgg.nl/Ted"
SRC_URI="ftp://ftp.nluug.nl/pub/editors/ted/${P}.src.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND=">=x11-libs/openmotif-2.1.30
		>=media-libs/tiff-3.5.7
		>=media-libs/jpeg-6b
		>=media-libs/libpng-1.2.3
		>=media-libs/xpm-3.4k"
RDEPEND=${DEPEND}


S="${WORKDIR}/Ted-2.11"


src_unpack() {
	tar --use=gzip -xvf /usr/portage/distfiles/${A}
	cd ${S}/Ted
	mv makefile.in makefile.in.orig
	sed 's@^CFLAGS=@CFLAGS= -DDOCUMENT_DIR=\\"/usr/share/doc/${PF}/Ted/\\"@' makefile.in.orig > makefile.in
}

src_compile() {
	cd ${S} || die "where are we?" $(pwd)

	for dir in Ted tedPackage appFrame appUtil ind bitmap libreg; do
		(
			cd ${dir};
			./configure \
				--host=${CHOST} \
				--prefix=/usr \
				--infodir=/usr/share/info \
				--cache-file=../config.cache \
				--mandir=/usr/share/man || die "./configure failed"
		)
	done
	#
	# The makefile doesn't really allow parallel make, but it does
	# no harm either.
	#
	emake DEF_AFMDIR=-DAFMDIR=\\\"/usr/share/Ted/afm\\\" \
		DEF_INDDIR=-DINDDIR=\\\"/usr/share/Ted/ind\\\" \
		package.shared || die
}

src_install () {
	cd ${WORKDIR}
	cd ..
	(
		mkdir temp/pkg;
		cd temp/pkg || die "Couldn't cd to package"
		tar --use=gzip -xvf ../../work/Ted-2.11/tedPackage/Ted*.tar.gz || die;
	) || die
	mkdir -p ${D}/usr/share/Ted || die "mkdir Ted failed"
	cp -R temp/pkg/afm ${D}/usr/share/Ted/afm || die
	cp -R temp/pkg/ind ${D}/usr/share/Ted/ind || die

	exeinto /usr/bin
	doexe temp/pkg/bin/* || die

	mkdir -p ${D}/usr/share/doc/${P}
	cp -R temp/pkg/Ted ${D}/usr/share/doc/${P} || die

	rm -rf temp
}
