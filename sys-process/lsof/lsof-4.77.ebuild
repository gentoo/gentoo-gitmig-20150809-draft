# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/lsof/lsof-4.77.ebuild,v 1.2 2006/08/24 02:49:45 vapier Exp $

inherit eutils flag-o-matic fixheadtails toolchain-funcs

MY_P=${P/-/_}
DESCRIPTION="Lists open files for running Unix processes"
HOMEPAGE="ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/"
SRC_URI="ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/${MY_P}.tar.bz2
	ftp://vic.cc.purdue.edu/pub/tools/unix/lsof/${MY_P}.tar.bz2
	ftp://ftp.cerias.purdue.edu/pub/tools/unix/sysutils/lsof/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="static"

DEPEND=""

S=${WORKDIR}/${MY_P}/${MY_P}_src

src_unpack() {
	unpack ${A}
	cd ${MY_P}
	tar xf ${MY_P}_src.tar || die

	# now patch the scripts to automate everything
	cd "${S}"
	ht_fix_file Configure Customize
	touch .neverInv
	epatch "${FILESDIR}"/4.73-answer-config.patch
}

src_compile() {
	use static && append-ldflags -static

	./Configure linux || die "configure failed"

	# Make sure we use proper toolchain
	sed -i \
		-e "/^CC=/s:cc:$(tc-getCC):" \
		-e "/^AR=/s:ar:$(tc-getAR):" \
		-e "/^RANLIB=/s:ranlib:$(tc-getRANLIB):" \
		Makefile lib/Makefile

	emake all || die "emake failed"
}

src_install() {
	dosbin lsof || die "dosbin"
	dolib lib/liblsof.a || die "dolib"

	insinto /usr/share/lsof/scripts
	doins scripts/*

	doman lsof.8
	dodoc 00*
}
