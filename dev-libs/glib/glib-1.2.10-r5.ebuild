# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-1.2.10-r5.ebuild,v 1.34 2004/10/23 06:25:55 mr_bones_ Exp $

inherit libtool gnuconfig flag-o-matic eutils

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/${P}.tar.gz
	 ftp://ftp.gnome.org/pub/GNOME/stable/sources/glib/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390 ~ppc-macos"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	# Allow glib to build with gcc-3.4.x
	# Closes Bug #47047
	epatch ${FILESDIR}/${P}-gcc34-fix.patch
}

src_compile() {
	elibtoolize

	# elibtoolize breaks (see brad's comments below, left here for
	# historical purposes) but libtoolize won't work either because
	# there is no libtoolize in the stage1 and it brings in nasty
	# deps if you try to install it during bootstrap.
	# elibtoolize seems to be working decently on x86. As a temporary
	# fix for amd64 users to be able to bootstrap, we run gnuconfig.
	# The glib .a's will be broken, but it's a start.
	# See bug 47950 for more information.
	# -- avenj@gentoo.org  19 Apr 04

	gnuconfig_update


	# For some reason, elibtoolize stopped doing its job in the last couple
	# of days on this ebuild, and amd64 won't compile it anymore, need to
	# manually run libtoolize, I need to inspect the libtool.eclass I guess.
	# Brad House <brad_mssw@gentoo.org> 1/2/2004
#	libtoolize -c -f

	# Bug 48839: pam fails to build on ia64
	# The problem is that it attempts to link a shared object against
	# libglib.a; this library needs to be built with -fPIC.  Since
	# this package doesn't contain any significant binaries, build the
	# whole thing with -fPIC (23 Apr 2004 agriffis)
	append-flags -fPIC

	econf \
		--with-threads=posix \
		--enable-debug=yes || die

	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog README* INSTALL NEWS
	dohtml -r docs

	cd ${D}/usr/$(get_libdir) || die
	if use ppc-macos || use macos ; then
		chmod 755 libgmodule-1.2.*.dylib
	else
		chmod 755 libgmodule-1.2.so.*
	fi
}
