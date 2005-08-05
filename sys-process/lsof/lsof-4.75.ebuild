# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/lsof/lsof-4.75.ebuild,v 1.3 2005/08/05 12:50:27 gustavoz Exp $

inherit eutils flag-o-matic fixheadtails toolchain-funcs

MY_P=${P/-/_}
DESCRIPTION="Lists open files for running Unix processes"
HOMEPAGE="ftp://vic.cc.purdue.edu/pub/tools/unix/lsof/README"
SRC_URI="ftp://vic.cc.purdue.edu/pub/tools/unix/lsof/${MY_P}.tar.gz
	ftp://ftp.cerias.purdue.edu/pub/tools/unix/sysutils/lsof/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ~ppc ~ppc64 s390 sparc x86"
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
	# #26576 lsof 4.71 compile with -fstack-protector
	use alpha && filter-flags -fstack-protector
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
