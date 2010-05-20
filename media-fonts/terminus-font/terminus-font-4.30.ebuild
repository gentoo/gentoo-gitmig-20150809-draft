# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/terminus-font/terminus-font-4.30.ebuild,v 1.6 2010/05/20 13:07:27 pva Exp $

EAPI="3"

inherit eutils font

DESCRIPTION="A clean fixed font for the console and X11"
HOMEPAGE="http://www.is-vn.bg/hamster/"
SRC_URI="http://www.is-vn.bg/hamster/${P}.tar.gz
		ru-dv? ( http://www.is-vn.bg/hamster/${P}-dv1.diff.gz )
		ru-g? ( http://www.is-vn.bg/hamster/${P}-ge1.diff.gz )
		quote? ( http://www.is-vn.bg/hamster/${P}-gq2.diff.gz )
		width? ( http://www.is-vn.bg/hamster/${P}-cm2.diff.gz )
		bolddiag? ( http://www.is-vn.bg/hamster/${P}-kx3.diff.gz
				a-like-o? ( http://www.is-vn.bg/hamster/${P}-kx3-ao2.diff.gz )
				ru-i? ( http://www.is-vn.bg/hamster/${P}-kx3-ij1.diff.gz )
				ru-k? ( http://www.is-vn.bg/hamster/${P}-kx3-ka2.diff.gz ) )
		!bolddiag? ( a-like-o? ( http://www.is-vn.bg/hamster/${P}-ao2.diff.gz )
				ru-i? ( http://www.is-vn.bg/hamster/${P}-ij1.diff.gz )
				ru-k? ( http://www.is-vn.bg/hamster/${P}-ka2.diff.gz ) )
			"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"
IUSE="a-like-o ru-dv +ru-g quote ru-i ru-k width bolddiag +psf raw-font-data +pcf"

DEPEND="dev-lang/perl
		sys-apps/gawk
		app-arch/gzip
		pcf? ( x11-apps/bdftopcf )"
RDEPEND=""

FONTDIR=/usr/share/fonts/terminus
DOCS="README README-BG"

pkg_setup() {
	# Note: that pcf fonts can be loaded by freetype even if X is not installed.
	# That's why configuration +pcf and -X is supported, bug #155783.
	if use X && ! use pcf ; then
		eerror "Fonts which works with Xserver are intalled only if pcf is enabled."
		die "Either disable X use flag or enabled pcf."
	fi

	font_pkg_setup
}

src_prepare() {
	# Upstream patches. Some of them are suggested to be applied by default
	# dv - de NOT like latin g, but like caps greek delta
	#      ve NOT like greek beta, but like caps latin B
	# ge - ge NOT like "mirrored" latin s, but like caps greek gamma
	# ka - small ka NOT like minimised caps latin K, but like small latin k
	if use bolddiag; then
		epatch "${WORKDIR}"/${P}-kx3.diff
		use a-like-o && epatch "${WORKDIR}"/${P}-kx3-ao2.diff
		use ru-i && epatch "${WORKDIR}"/${P}-kx3-ij1.diff
		use ru-k && epatch "${WORKDIR}"/${P}-kx3-ka2.diff
	else
		use a-like-o && epatch "${WORKDIR}"/${P}-ao2.diff
		use ru-i && epatch "${WORKDIR}"/${P}-ij1.diff
		use ru-k && epatch "${WORKDIR}"/${P}-ka2.diff
	fi
	use ru-dv && epatch "${WORKDIR}"/${P}-dv1.diff
	use ru-g && epatch "${WORKDIR}"/${P}-ge1.diff
	use quote && epatch "${WORKDIR}"/${P}-gq2.diff
	use width && epatch "${WORKDIR}"/${P}-cm2.diff
}

src_configure() {
	# selfwritten configure script
	./configure \
		--prefix="${EPREFIX}"/usr \
		--psfdir="${EPREFIX}"/usr/share/consolefonts \
		--acmdir="${EPREFIX}"/usr/share/consoletrans \
		--unidir="${EPREFIX}"/usr/share/consoletrans \
		--x11dir="${EPREFIX}"/${FONTDIR} || die
}

src_compile() {
	if use psf; then emake psf txt || die; fi
	if use raw-font-data; then emake raw || die; fi
	if use pcf; then emake pcf || die; fi
}

src_install() {
	if use psf; then
		emake DESTDIR="${D}" install-psf install-uni install-acm install-ref || die
	fi
	if use raw-font-data; then
		emake DESTDIR="${D}" install.raw || die
	fi
	if use pcf; then
		emake DESTDIR="${D}" install-pcf || die
	fi

	font_src_install
}
