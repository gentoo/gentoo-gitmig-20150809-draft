# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-2.2.3.ebuild,v 1.16 2004/03/22 05:24:57 vapier Exp $

inherit libtool

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.2/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="x86 ppc sparc alpha hppa mips amd64 ia64 s390 ppc64"
IUSE="doc debug"

DEPEND=">=dev-util/pkgconfig-0.14
	>=sys-devel/gettext-0.11
	doc? ( !s390? ( >=dev-util/gtk-doc-0.9-r2 ) )"

RDEPEND="virtual/glibc"

src_compile() {

	local myconf=""
	use debug && myconf="${myconf}  --enable-debug=yes"

	econf \
		`use_enable doc gtk-doc` \
		--with-threads=posix \
		${myconf} || die

	emake || die
}

src_install() {
	einstall || die

	# Consider invalid UTF-8 filenames as locale-specific.
	dodir /etc/env.d
	echo "G_BROKEN_FILENAMES=1" > ${D}/etc/env.d/50glib2

	dodoc AUTHORS ChangeLog README* INSTALL NEWS NEWS.pre-1-3
}
