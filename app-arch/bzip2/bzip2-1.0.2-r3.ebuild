# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/bzip2/bzip2-1.0.2-r3.ebuild,v 1.6 2004/04/01 02:35:59 vapier Exp $

inherit gcc flag-o-matic

DESCRIPTION="A high-quality data compressor used extensively by Gentoo Linux"
HOMEPAGE="http://sources.redhat.com/bzip2/"
SRC_URI="ftp://sources.redhat.com/pub/bzip2/v102/${P}.tar.gz"

LICENSE="BZIP2"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha mips hppa ia64 ppc64 s390"
IUSE="build static debug"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	# for optimizations, we keep -fomit-frame-pointer and -fno-strength-reduce
	# for speed.  -fstrength-reduce seems to slow down the code slightly on x86.
	# (drobbins)
	use static && append-flags -static
	use debug && sed -i 's:-fomit-frame-pointer::g' Makefile
	sed -i \
		-e 's:\$(PREFIX)/man:\$(PREFIX)/share/man:g' \
		-e "s:-O2:${CFLAGS}:g" \
		Makefile || die
	sed -i \
		-e "s:-O2:${CFLAGS}:g" \
		Makefile-libbz2_so || die
}

src_compile() {
	if ! use build
	then
		emake CC="$(gcc-getCC)" CXX="$(gcc-getCXX)" -f Makefile-libbz2_so all || die "Make failed"
	fi
	emake CC="$(gcc-getCC)" CXX="$(gcc-getCXX)" all || die "Make failed"
}

src_install() {
	if ! use build
	then
		make PREFIX=${D}/usr install || die
		mv ${D}/usr/bin ${D}

		# These are symlinks to bzip2 ...
		for x in bunzip2 bzcat
		do
			if [ -f "${D}/bin/${x}" ]
			then
				rm -f ${D}/bin/${x}
				dosym bzip2 /bin/${x}
			fi
		done

		dolib.so ${S}/libbz2.so.${PV}
		dosym /usr/lib/libbz2.so.${PV} /usr/lib/libbz2.so.1.0
		dosym /usr/lib/libbz2.so.${PV} /usr/lib/libbz2.so

		dodoc README LICENSE CHANGES Y2K_INFO
		docinto txt
		dodoc *.txt
		docinto ps
		dodoc *.ps
		dohtml manual_*.html
	else
		into /
		dobin bzip2
		dosym bzip2 /bin/bzcat
		dosym bzip2 /bin/bunzip2
	fi
}
