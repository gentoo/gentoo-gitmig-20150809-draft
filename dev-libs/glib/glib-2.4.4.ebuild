# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-2.4.4.ebuild,v 1.4 2004/08/05 18:00:39 gmsoft Exp $

inherit libtool

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.4/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="x86 ~ppc ~sparc ~mips ~alpha ~arm hppa ~amd64 ~ia64 ~ppc64 ~s390 ~macos"
IUSE="doc"

DEPEND=">=dev-util/pkgconfig-0.14
	>=sys-devel/gettext-0.11
	doc? ( !s390? ( >=dev-util/gtk-doc-1 ) )"

RDEPEND="virtual/libc"

src_compile() {

	if use macos; then
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
