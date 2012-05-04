# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/qemacs/qemacs-0.4.0_pre20090420-r1.ebuild,v 1.3 2012/05/04 11:03:07 ssuominen Exp $

EAPI=4
inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="QEmacs is a very small but powerful UNIX editor"
HOMEPAGE="http://savannah.nongnu.org/projects/qemacs"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="png unicode X xv"

RDEPEND="png? ( media-libs/libpng:0 )
	X? (
		x11-libs/libX11
		x11-libs/libXext
		xv? ( x11-libs/libXv )
		)"
DEPEND="${RDEPEND}
	>=app-text/texi2html-5"

S=${WORKDIR}/${PN}

RESTRICT="test"

DOCS="Changelog config.eg README TODO"

src_prepare() {
	# Removes forced march setting and align-functions on x86, as they
	# would override user's CFLAGS..
	epatch "${FILESDIR}"/${PN}-0.4.0_pre20080605-Makefile.patch
	# Make backup files optional
	epatch "${FILESDIR}"/${PN}-0.4.0_pre20080605-make_backup.patch
	# Suppress stripping
	epatch "${FILESDIR}"/${P}-nostrip.patch

	use unicode && epatch "${FILESDIR}"/${PN}-0.3.2_pre20070226-tty_utf8.patch

	# Change the manpage to reference a /real/ file instead of just an
	# approximation.  Purely cosmetic!
	sed -i -e "s,^/usr/share/doc/qe,&-${PVR}," qe.1 || die

	# Fix compability with app-text/texi2html >= 5
	sed -i -e '/texi2html/s:-number:&-sections:' Makefile || die
}

src_configure() {
	# when using any other CFLAGS than -O0, qemacs will segfault on startup,
	# see bug 92011
	replace-flags -O? -O0
	econf \
		--cc="$(tc-getCC)" \
		$(use_enable X x11) \
		$(use_enable png) \
		$(use_enable xv)
}

src_compile() {
	# Does not support parallel building.
	emake -j1
}

src_install() {
	default

	dohtml *.html

	# Fix man page location
	mv -vf "${ED}"/usr/{,share/}man || die

	# Install headers so users can build their own plugins.
	insinto /usr/include/qe
	doins {cfb,config,cutils,display,fbfrender,libfbf,qe,qeconfig,qestyles,qfribidi}.h

	pushd libqhtml >/dev/null
	insinto /usr/include/qe/libqhtml
	doins css.h cssid.h htmlent.h
	popd >/dev/null
}
