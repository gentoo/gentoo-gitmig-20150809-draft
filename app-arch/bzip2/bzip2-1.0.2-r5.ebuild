# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/bzip2/bzip2-1.0.2-r5.ebuild,v 1.2 2005/03/31 15:52:22 kugelfang Exp $

inherit toolchain-funcs flag-o-matic

DESCRIPTION="A high-quality data compressor used extensively by Gentoo Linux"
HOMEPAGE="http://sources.redhat.com/bzip2/"
SRC_URI="ftp://sources.redhat.com/pub/bzip2/v102/${P}.tar.gz"

LICENSE="BZIP2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="build static"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-NULL-ptr-check.patch
	epatch "${FILESDIR}"/${P}-makefile-CFLAGS.patch
	epatch "${FILESDIR}"/${P}-saneso.patch
	epatch "${FILESDIR}"/${P}-progress.patch
	sed -i -e 's:\$(PREFIX)/man:\$(PREFIX)/share/man:g' Makefile || die
	# make the Makefile multilib aware <kugelfang@gentoo.org>
	sed -i -e "s:\/lib\(\ \|\/\|$\):\/$(get_libdir)\1:g" Makefile \
		|| die "sed failed: get_libdir"

	use static && append-flags -static

	# bzip2 will to run itself after it has built itself which we
	# can't do if we are cross compiling. -solar
	if [[ -x /bin/bzip2 ]] && tc-is-cross-compiler ; then
		sed -i -e 's:./bzip2 -:bzip2 -:g' Makefile || die
	fi
}

src_compile() {
	local makeopts="
		CC=$(tc-getCC)
		AR=$(tc-getAR)
		RANLIB=$(tc-getRANLIB)
	"
	if ! use build ; then
		emake ${makeopts} -f Makefile-libbz2_so all || die "Make failed libbz2"
	fi
	emake ${makeopts} all || die "Make failed"
}

src_install() {
	if ! use build ; then
		make PREFIX="${D}"/usr install || die
		mv "${D}"/usr/bin "${D}"

		# These are symlinks to bzip2 ...
		for x in bunzip2 bzcat ; do
			if [[ -f ${D}/bin/${x} ]] ; then
				rm -f ${D}/bin/${x}
				dosym bzip2 /bin/${x}
			fi
		done

		dolib.so "${S}"/libbz2.so.${PV}
		dosym libbz2.so.${PV} /usr/$(get_libdir)/libbz2.so.1.0
		dosym libbz2.so.${PV} /usr/$(get_libdir)/libbz2.so
		dosym libbz2.so.${PV} /usr/$(get_libdir)/libbz2.so.1

		dodoc README CHANGES Y2K_INFO
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
