# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-1.2.10-r5.ebuild,v 1.12 2004/01/03 02:52:09 brad_mssw Exp $

inherit libtool

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/${P}.tar.gz
	 ftp://ftp.gnome.org/pub/GNOME/stable/sources/glib/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="amd64 x86 ppc sparc alpha mips hppa arm ia64 ppc64"

DEPEND="virtual/glibc"

src_compile() {
#	elibtoolize
	# For some reason, elibtoolize stopped doing its job in the last couple
	# of days on this ebuild, and amd64 won't compile it anymore, need to
	# manually run libtoolize, I need to inspect the libtool.eclass I guess.
	# Brad House <brad_mssw@gentoo.org> 1/2/2004
	libtoolize -c -f

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
