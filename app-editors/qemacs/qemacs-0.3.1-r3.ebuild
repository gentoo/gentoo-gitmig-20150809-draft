# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/qemacs/qemacs-0.3.1-r3.ebuild,v 1.4 2006/08/09 15:54:04 kugelfang Exp $

inherit eutils

DESCRIPTION="QEmacs (for Quick Emacs) is a very small but powerful UNIX editor."
HOMEPAGE="http://fabrice.bellard.free.fr/qemacs/"
SRC_URI="http://fabrice.bellard.free.fr/qemacs/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="X png unicode xv"

# For those so inclined, the libXv dep can probably
# be made conditional on the xv USE flag somehow.
RDEPEND="X? ( || ( x11-libs/libXv virtual/x11 ) )
	png? ( =media-libs/libpng-1.2* )"
DEPEND="${RDEPEND}
	X? ( || ( ( x11-libs/libXft
				x11-proto/xextproto )
			virtual/x11 ) )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Add a patch to install to DESTDIR, make directories during install
	# and install the binary/man page using the qemacs name to avoid clash
	# with app-editors/qe.
	# Also removes forced march setting and align-functions on x86, as
	# they would override user's CFLAGS..
	epatch ${FILESDIR}/${P}-Makefile-gentoo.patch
	# Change the references to the qe binary to reflect the installed name
	# qemacs.
	epatch ${FILESDIR}/${P}-manpage-ref-fix.patch
	# Set the datadir to qemacs, upstream installs in to qe which conflicts
	# with files installed in app-editors/qe.  Currently no breakage
	# occurs, but it makes sense to change before that happens.
	epatch ${FILESDIR}/${P}-qemacs-datadir.patch
	epatch ${FILESDIR}/${P}-configure-gentoo.patch
	epatch ${FILESDIR}/${P}-make_backup.patch
	useq unicode && epatch ${FILESDIR}/${P}-tty_utf8.patch
	epatch ${FILESDIR}/${P}-gcc-3.4.patch
	# Patches to avoid compilation errors with GCC 4, see bug #141292
	epatch ${FILESDIR}/${P}-gcc4_tty_c.patch
	epatch ${FILESDIR}/${P}-gcc4_x11_c.patch
	epatch ${FILESDIR}/${P}-gcc4_charset_c.patch
	# port to new libpng API, see bug #141566
	useq png && epatch ${FILESDIR}/${P}-libpng-1_2.patch
	# Change the manpage to reference a /real/ file instead of just an
	# approximation.  Purely cosmetic!
	sed -i "s,^/usr/share/doc/qemacs,&-${PVR}," qe.1
}

src_compile() {
	# when using any other CFLAGS than -O0, qemacs will segfault on startup, see bug #92011
	CFLAGS="-O0"
	econf $(use_enable X x11) \
		$(use_enable png) \
		$(use_enable xv) \
		|| die "econf failed"
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
	make install DESTDIR=${D} || die
	dodoc Changelog README TODO config.eg
	dohtml *.html

	insinto /usr/share/doc/${PF}/plugin-example/
	doins plugin-example/*

	# Install headers so users can build their own plugins.
	insinto /usr/include/qemacs
	doins cfb.h config.h cutils.h display.h fbfrender.h libfbf.h qe.h \
		qeconfig.h qestyles.h qfribidi.h
	cd libqhtml
	insinto /usr/include/qemacs/libqhtml
	doins {css{,id},htmlent}.h
}

pkg_postinst() {
	einfo "This version of qemacs is not entirely backwards compatible with"
	einfo "versions prior to 0.3.1-r1."
	echo
	einfo "The name of the binary has been changed to qemacs, to fix a name"
	einfo "clash with app-editors/qe."
	echo
	einfo "The location of user config files have been changed to ~/.qemacs, to"
	einfo "remove some ambiguity."
}
