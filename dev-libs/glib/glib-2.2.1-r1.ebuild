# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-2.2.1-r1.ebuild,v 1.1 2003/05/29 07:39:53 utx Exp $

inherit libtool

IUSE="doc"
S=${WORKDIR}/${P}
DESCRIPTION="The GLib library of C routines"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.2/${P}.tar.bz2"
HOMEPAGE="http://www.gtk.org/"

SLOT="2"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc alpha arm hppa mips"

DEPEND=">=dev-util/pkgconfig-0.14.0
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"

RDEPEND="virtual/glibc"

src_compile() {
	# Seems libtool have another wierd bug, try to fix it
	# with a fix for nautilus, bug #4190
	elibtoolize --reverse-deps
	
	local myconf=""
	use doc \
		&& myconf="${myconf} --enable-gtk-doc" \
		|| myconf="${myconf} --disable-gtk-doc"

	if [ -n "$DEBUGBUILD" ]; then
		myconf="${myconf}  --enable-debug=yes"
    	fi

	econf \
		--with-threads=posix \
		${myconf} || die

	emake || die
}

src_install() {
	einstall || die

	# Consider invalid UTF-8 filenames as locale-specific.
	dodir /etc/env.d
	echo "G_BROKEN_FILENAMES=1" >${D}/etc/env.d/50glib2
    
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS NEWS.pre-1-3
}

pkg_postinst() {
	env-update
}

pkg_postrm() {
	env-update
}
