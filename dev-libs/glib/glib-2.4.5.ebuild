# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-2.4.5.ebuild,v 1.10 2004/09/24 13:08:33 vapier Exp $

inherit libtool

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.4/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~macos mips ~ppc ~ppc64 ~ppc-macos s390 sparc x86"
IUSE="doc"

DEPEND=">=dev-util/pkgconfig-0.14
	>=sys-devel/gettext-0.11
	doc? ( >=dev-util/gtk-doc-1 )"
RDEPEND="virtual/libc"

src_compile() {
	if use macos; then
		glibtoolize
	elif use ppc-macos; then
		glibtoolize
	else
		elibtoolize
	fi

	econf \
		--with-threads=posix \
		`use_enable doc gtk-doc` \
		|| die

	emake || die
}

src_install() {
	# einstall || die
	make DESTDIR=${D} install || die

	# Consider invalid UTF-8 filenames as locale-specific.
	# FIXME : we should probably move to suggesting G_FILENAME_ENC
	dodir /etc/env.d
	echo "G_BROKEN_FILENAMES=1" > ${D}/etc/env.d/50glib2

	dodoc AUTHORS ChangeLog* README* INSTALL NEWS*
}
