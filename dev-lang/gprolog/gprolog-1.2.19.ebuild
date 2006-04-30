# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gprolog/gprolog-1.2.19.ebuild,v 1.5 2006/04/30 04:50:22 halcy0n Exp $

inherit autotools eutils flag-o-matic

IUSE="doc"

DEPEND="virtual/libc"

DESCRIPTION="GNU Prolog is a native Prolog compiler with constraint solving over finite domains (FD)"
HOMEPAGE="http://pauillac.inria.fr/~diaz/gnu-prolog/"
SRC_URI="ftp://ftp.inria.fr/INRIA/Projects/contraintes/${PN}/unstable/${P}.tar.gz"
S=${WORKDIR}/${P}/src

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~ppc-macos x86"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/"${P}"-CFLAGS.patch
	epatch "${FILESDIR}"/"${P}"-bootstrap.patch
	epatch "${FILESDIR}"/"${P}"-gcc4.patch
	epatch "${FILESDIR}"/"${P}"-noexecstack.patch
	epatch "${FILESDIR}"/"${P}"-test.patch
	sed -i -e "s:TXT_FILES      = @TXT_FILES@:TXT_FILES=:" Makefile.in
}

src_compile() {
	eautoconf

	CFLAGS_MACHINE="`get-flag -march`"
	CFLAGS_MACHINE="${CFLAGS_MACHINE} `get-flag -mcpu`"
	CFLAGS_MACHINE="${CFLAGS_MACHINE} `get-flag -mtune`"

	filter-flags ${CFLAGS_MACHINE}

	local myconf

	if [[ $(gcc-major-version) == "4" ]] ; then
		append-flags "-O0"
		myconf="${myconf} --disable-fast-call"
	fi

	CFLAGS_MACHINE="${CFLAGS_MACHINE}" \
	econf \
		${myconf} \
		--with-c-flags="${CFLAGS}" \
		--with-install-dir="${D}"/usr \
		--with-doc-dir="${D}"/usr/share/doc/${PF} \
		--with-html-dir="${D}"/usr/share/doc/${PF}/html \
		--with-examples-dir="${D}"/usr/share/doc/${PF}/examples \
		|| die "econf failed"

	emake -j1 || die "emake failed"
}

src_install() {
	make install-system || die "make install-system failed"

	if use doc; then
		make install-doc || die "make install-doc failed"
		make install-html || die "make install-html failed"
		make install-examples || die "make install-examples failed"
	fi

	cd ${S}/..
	dodoc ChangeLog INSTALL NEWS PROBLEMS README VERSION
}
