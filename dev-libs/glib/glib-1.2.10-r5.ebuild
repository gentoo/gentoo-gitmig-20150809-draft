# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-1.2.10-r5.ebuild,v 1.9 2003/08/03 02:06:16 vapier Exp $

inherit libtool

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/${P}.tar.gz
	 ftp://ftp.gnome.org/pub/GNOME/stable/sources/glib/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="amd64 x86 ppc sparc alpha mips hppa arm"

DEPEND="virtual/glibc"

src_compile() {
	elibtoolize

	econf \
		--with-threads=posix \
		--enable-debug=yes || die

	if [ "${ARCH}" = "alpha" ] ; then
		emake CFLAGS="${CFLAGS} -fPIC" || die
	else
		emake || die
	fi
}

src_install() {
	einstall || die

	( cd ${D}/usr/lib ; chmod 755 libgmodule-1.2.so.* )

	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS
	dohtml -r docs
}
