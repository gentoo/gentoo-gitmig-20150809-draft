# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mpatrol/mpatrol-1.4.8-r3.ebuild,v 1.5 2012/03/18 15:40:56 armin76 Exp $

EAPI=1

inherit eutils flag-o-matic

DESCRIPTION="A link library for controlling and tracing dynamic memory allocation. Attempts to diagnose run-time errors that are caused by misuse of dynamically allocated memory. Simple integration via a single header."
HOMEPAGE="http://www.cbmamiga.demon.co.uk/mpatrol/"
SRC_URI="http://www.cbmamiga.demon.co.uk/mpatrol/files/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="X"

S="${WORKDIR}/${PN}"

# To use X, mpatrol requires Motif
DEPEND="X? ( >=x11-libs/openmotif-2.3:0 )"
RDEPEND="${DEPEND}
	!dev-lang/mercury"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-soname.patch"

	#bug 272505
	epatch "${FILESDIR}/${P}-gcc44-glibc210.patch"

	cd "${S}/src"
	# [Bug 176592] textrel fix for dev-libs/mpatrol
	epatch "${FILESDIR}/${PN}-textrel-fix.patch"

	sed -i \
		-e 's:#define MP_SYMBOL_LIBS , MP_LIBNAME(bfd), MP_LIBNAME(iberty):#define MP_SYMBOL_LIBS , MP_LIBNAME(bfd):' config.h \
			|| die "sed config.h failed"

	cd "${S}/build/unix"
	sed -i \
		-e 's:^OFLAGS.= -O3:OFLAGS = ${OPT_FLAGS}:' Makefile \
			|| die "sed Makefile for CFLAGS failed"

	sed -i \
		-e 's:$(LD) $(LDFLAGS) -o $@ $(SHARED_MPTOBJS):$(LD) $(LDFLAGS) -liberty -o $@ $(SHARED_MPTOBJS):' Makefile \
			|| die "sed Makefile for fixing -libiberty failed"

	epatch "${FILESDIR}"/${PN}-ldflags.diff

	if use X; then
		sed -i \
			-e 's:^GUISUP.= false:GUISUP = true:' Makefile \
			|| die "sed Makefile for GUISUP failed"
	fi
}

src_compile() {
	cd "${S}/build/unix"
	emake STRIPPROG=true OPT_FLAGS="${CFLAGS} -Wa,--noexecstack" LDOPTS="${LDFLAGS}" all || die "emake failed"
}

# **
# ** The install is straightforward, but a bit on the odd side. The author
# ** gives a list of things that need to be done, rather than attempt to
# ** make an install target. --nj
# **
src_install () {
	cd "${S}/build/unix"
	dobin mleak mpatrol mprof mptrace || die
	dolib.so lib*.so.* || die
	dolib.a  lib*.a || die

	# Each lib needs a symlink from the .so level
	#for L in lib*.so.*; do
	#	dosym $L /usr/lib/`echo $L | sed 's:^\([^\.]*\.so\).*:\1:'`
	#done

	insinto /usr
	cd "${S}/bin"
	dobin * || die

	insinto /usr/include/
	cd "${S}/src"
	doins mpatrol.h mpalloc.h mpdebug.h || die

	insinto /usr/include/mpatrol
	doins "${S}"/tools/*.h || die

	doman "${S}"/man/man?/* || die

	cd "${S}"
	dodoc AUTHORS ChangeLog NEWS README THANKS VERSION pkg/lsm/*lsm || die

	cd "${S}/doc"
	dodoc *.dvi *.ps *.pdf *.txt || die
	doinfo mpatrol.info || die
	dohtml mpatrol.html || die

	docinto images
	dodoc images/*.{eps,pdf} || die

	insinto /usr/share/doc/${PF}/html/images
	doins images/*.jpg || die
}

pkg_postinst() {
	elog " Please review the documentation in /usr/share/doc/$PF"
}
