# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/qemacs/qemacs-0.4.0_pre20080605.ebuild,v 1.4 2009/04/22 20:40:18 maekke Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="QEmacs is a very small but powerful UNIX editor"
HOMEPAGE="http://fabrice.bellard.free.fr/qemacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="X png unicode xv"
RESTRICT="strip"

DEPEND="X? ( x11-libs/libX11
			x11-libs/libXext
			xv? ( x11-libs/libXv ) )
	png? ( =media-libs/libpng-1.2* )"

RDEPEND="${DEPEND}"

DEPEND="${DEPEND}
	app-text/texi2html"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Add a patch to install to DESTDIR, make directories during install
	# and install the binary/man page using the qemacs name to avoid clash
	# with app-editors/qe.
	# Also removes forced march setting and align-functions on x86, as
	# they would override user's CFLAGS..
	epatch "${FILESDIR}/${P}-Makefile-gentoo.patch"
	# Change the references to the qe binary to reflect the installed name
	# qemacs.
	epatch "${FILESDIR}/${PN}-0.3.1-manpage-ref-fix.patch"
	# Set the datadir to qemacs, upstream installs in to qe which conflicts
	# with files installed in app-editors/qe.  Currently no breakage
	# occurs, but it makes sense to change before that happens.
	epatch "${FILESDIR}/${P}-qemacs-datadir.patch"
	epatch "${FILESDIR}/${P}-make_backup.patch"

	useq unicode && epatch "${FILESDIR}/${PN}-0.3.2_pre20070226-tty_utf8.patch"
	# Change the manpage to reference a /real/ file instead of just an
	# approximation.  Purely cosmetic!
	sed -i "s,^/usr/share/doc/qemacs,&-${PVR}," qe.1
}

src_compile() {
	# when using any other CFLAGS than -O0, qemacs will segfault on startup, see bug #92011
	replace-flags -O? -O0
	econf --cc="$(tc-getCC)" \
		$(use_enable X x11) \
		$(use_enable png) \
		$(use_enable xv) \
		|| die "econf failed"
	# Does not support parallel building
	emake -j1 || die
}

src_test() {
	# There are some files purporting to be tests in the tarball, however
	# there is no defined way to use them and I imagine even if there was
	# it would require user interaction.
	# The toplevel Makefile calls the test target from the non-existant
	# tests/Makefile, so just noop to stop errors if maketest is set.
	:
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc Changelog README TODO config.eg
	dohtml *.html

	# Install headers so users can build their own plugins.
	insinto /usr/include/qemacs
	doins cfb.h config.h cutils.h display.h fbfrender.h libfbf.h qe.h \
		qeconfig.h qestyles.h qfribidi.h
	cd libqhtml
	insinto /usr/include/qemacs/libqhtml
	doins {css{,id},htmlent}.h
}
