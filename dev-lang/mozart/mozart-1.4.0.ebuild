# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mozart/mozart-1.4.0.ebuild,v 1.7 2010/08/25 07:56:38 keri Exp $

inherit elisp-common eutils

MY_P="mozart-${PV}.20080704"

DESCRIPTION="Mozart is an advanced development platform for intelligent, distributed applications"
HOMEPAGE="http://www.mozart-oz.org/"
SRC_URI="http://www.mozart-oz.org/download/mozart-ftp/store/1.4.0-2008-07-02-tar/mozart-1.4.0.20080704-src.tar.gz
	doc? ( http://www.mozart-oz.org/download/mozart-ftp/store/1.4.0-2008-07-02-tar/mozart-1.4.0.20080704-doc.tar.gz )"
LICENSE="Mozart"

SLOT="0"
KEYWORDS="-amd64 ~ppc -ppc64 ~sparc ~x86"
IUSE="doc emacs gdbm static tcl threads tk"

RDEPEND="dev-lang/perl
	dev-libs/gmp
	sys-libs/zlib
	emacs? ( virtual/emacs )
	gdbm? ( sys-libs/gdbm  )
	tcl? ( tk? (
			dev-lang/tk
			dev-lang/tcl ) )"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

SITEFILE=50${PN}-gentoo.el

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-cstdio.patch
	epatch "${FILESDIR}"/${P}-const-cast.patch
	epatch "${FILESDIR}"/${P}-ozhome.patch
	epatch "${FILESDIR}"/${P}-ozplatform-amd64.patch
	epatch "${FILESDIR}"/${P}-ozplatform-sparc.patch
	epatch "${FILESDIR}"/${P}-parallel-make.patch
	epatch "${FILESDIR}"/${P}-mkinstalldirs.patch
	epatch "${FILESDIR}"/${P}-contrib.patch
	epatch "${FILESDIR}"/${P}-dss-prefix.patch
	epatch "${FILESDIR}"/${P}-dss-pic.patch
	epatch "${FILESDIR}"/${P}-dss-libpath.patch
	epatch "${FILESDIR}"/${P}-nostrip.patch
}

src_compile() {
	local myconf="\
			--without-global-oz \
			--enable-opt=none"

	if use tcl && use tk ; then
		myconf="${myconf} --enable-wish"
	else
		myconf="${myconf} --disable-wish"
	fi

	econf \
		${myconf} \
		--disable-doc \
		--enable-contrib \
		--disable-contrib-micq \
		$(use_enable doc contrib-doc) \
		$(use_enable gdbm contrib-gdbm) \
		$(use_enable tk contrib-tk) \
		$(use_enable emacs compile-elisp) \
		$(use_enable static link-static) \
		$(use_enable threads threaded) \
		|| die "econf failed"

	emake bootstrap || die "emake bootstrap failed"
}

src_test() {
	cd "${S}"/share/test
	emake -j1 boot-oztest || die "emake boot-oztest failed"
	emake -j1 boot-check || die "emake boot-check failed"
}

src_install() {
	emake \
		PREFIX="${D}"/usr/lib/mozart \
		ELISPDIR="${D}${SITELISP}/${PN}" \
		install || die "emake install failed"

	dosym /usr/lib/mozart/bin/convertTextPickle /usr/bin/convertTextPickle
	dosym /usr/lib/mozart/bin/oldpickle2text /usr/bin/oldpickle2text
	dosym /usr/lib/mozart/bin/oz /usr/bin/oz
	dosym /usr/lib/mozart/bin/ozc /usr/bin/ozc
	dosym /usr/lib/mozart/bin/ozd /usr/bin/ozd
	dosym /usr/lib/mozart/bin/ozengine /usr/bin/ozengine
	dosym /usr/lib/mozart/bin/ozl /usr/bin/ozl
	dosym /usr/lib/mozart/bin/ozplatform /usr/bin/ozplatform
	dosym /usr/lib/mozart/bin/oztool /usr/bin/oztool
	dosym /usr/lib/mozart/bin/pickle2text /usr/bin/pickle2text
	dosym /usr/lib/mozart/bin/text2pickle /usr/bin/text2pickle

	if use emacs; then
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
			|| die "elisp-site-file-install failed"
	fi

	if use doc ; then
		dohtml -r "${WORKDIR}"/mozart/doc/*
	fi

	dodoc README
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
