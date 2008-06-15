# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/yamcha/yamcha-0.33-r1.ebuild,v 1.3 2008/06/15 20:34:09 loki_val Exp $

inherit perl-module eutils
# inherit distutils

DESCRIPTION="Yet Another Multipurpose CHunk Annotator"
HOMEPAGE="http://chasen.org/~taku/software/yamcha/"
SRC_URI="http://chasen.org/~taku/software/yamcha/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~amd64"

IUSE="perl"
#IUSE="python ruby"

DEPEND="sci-misc/tinysvm
	dev-lang/perl"
#RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-pm.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	econf || die
	emake || die

	if use perl ; then
		cd "${S}"/perl
		perl-module_src_compile || die
	fi

	# python module doesn't work on my box :(
	#if use python ; then
	#	cd ${S}/python
	#	distutils_src_compile || die
	#fi
}

src_test() {
	make check || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS README

	if use perl ; then
		cd "${S}"/perl
		perl-module_src_install || die
	fi

	# dies when installing
	#if use python ; then
	#	cd ${S}/python
	#	distutils_src_install || die
	#fi
}
