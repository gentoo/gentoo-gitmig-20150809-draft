# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-1.2.10-r5.ebuild,v 1.40 2005/04/07 04:42:23 dostrow Exp $

inherit libtool flag-o-matic eutils gnuconfig

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/${P}.tar.gz
	 ftp://ftp.gnome.org/pub/GNOME/stable/sources/glib/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sh sparc x86"
IUSE="hardened"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	# Allow glib to build with gcc-3.4.x #47047
	epatch ${FILESDIR}/${P}-gcc34-fix.patch

	use ppc64 && gnuconfig_update

	uclibctoolize

	if use ppc-macos; then
		darwintoolize
		gnuconfig_update
	fi

	if use ppc64 && use hardened; then
		replace-flags -O[2-3] -O1
	fi

	append-ldflags -ldl
						
}

src_compile() {
	# Bug 48839: pam fails to build on ia64
	# The problem is that it attempts to link a shared object against
	# libglib.a; this library needs to be built with -fPIC.  Since
	# this package doesn't contain any significant binaries, build the
	# whole thing with -fPIC (23 Apr 2004 agriffis)
	append-flags -fPIC

	econf \
		--with-threads=posix \
		--enable-debug=yes \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die

	dodoc AUTHORS ChangeLog README* INSTALL NEWS
	dohtml -r docs

	cd ${D}/usr/$(get_libdir) || die
	if use ppc-macos ; then
		chmod 755 libgmodule-1.2.*.dylib
	else
		chmod 755 libgmodule-1.2.so.*
	fi
}
