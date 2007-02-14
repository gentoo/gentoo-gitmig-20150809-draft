# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mozart/mozart-1.3.2.ebuild,v 1.1 2007/02/14 08:30:49 keri Exp $

inherit eutils

MY_P="mozart-${PV}.20060615"

DESCRIPTION="The Mozart Programming System is an advanced development platform for intelligent, distributed applications"
HOMEPAGE="http://www.mozart-oz.org/"
SRC_URI="http://www.mozart-oz.org/download/mozart-ftp/store/1.3.2-2006-06-15-tar/mozart-1.3.2.20060615-src.tar.gz
	doc? ( http://www.mozart-oz.org/download/mozart-ftp/store/1.3.2-2006-06-15-tar/mozart-1.3.2.20060615-doc.tar.gz )"
LICENSE="Mozart"

SLOT="0"
KEYWORDS="~x86"
IUSE="doc emacs gdbm static tcl threads tk"

DEPEND="dev-lang/perl
	dev-libs/gmp
	sys-devel/bison
	sys-devel/flex
	sys-libs/zlib
	gdbm? ( sys-libs/gdbm  )
	tcl? ( tk? (
			dev-lang/tk
			dev-lang/tcl ) )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-portage.patch
	epatch "${FILESDIR}"/${P}-contrib.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch
	epatch "${FILESDIR}"/${P}-nostrip.patch
	epatch "${FILESDIR}"/${P}-ozplatform.patch
}

src_compile() {
	cd "${S}"
	local myconf="\
			--without-global-oz \
			--enable-opt=none"

	if use emacs ; then
		myconf="${myconf} --enable-compile-elisp"
	else
		myconf="${myconf} --disable-compile-elisp"
	fi

	if use tcl && use tk ; then
		myconf="${myconf} --enable-wish"
	else
		myconf="${myconf} --disable-wish"
	fi

	econf \
		${myconf} \
		--enable-contrib \
		--enable-contrib-regex \
		--enable-contrib-os \
		--enable-contrib-micq \
		--enable-contrib-ri \
		--enable-contrib-davinci \
		--enable-contrib-reflect \
		--enable-contrib-investigator \
		--enable-contrib-fcp \
		--enable-contrib-compat \
		--enable-contrib-directory \
		--disable-contrib-psql \
		--disable-contrib-lp \
		--disable-doc \
		$(use_enable doc contrib-doc) \
		$(use_enable gdbm contrib-gdbm) \
		$(use_enable static link-static) \
		$(use_enable threads threaded) \
		|| die "econf failed"

	emake -j1 bootstrap || die "emake bootstrap failed"
}

src_install() {
	emake -j1 \
		PREFIX="${D}"/usr/lib/mozart \
		BINDIR="${D}"/usr/bin \
		install || die "emake install failed"

	if use doc ; then
		dohtml -r "${WORKDIR}"/mozart/doc/*
	fi

	dodoc README
}
