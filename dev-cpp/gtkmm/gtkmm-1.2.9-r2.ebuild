# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkmm/gtkmm-1.2.9-r2.ebuild,v 1.8 2004/01/29 04:29:09 agriffis Exp $

inherit eutils

DESCRIPTION="C++ interface for GTK+"
HOMEPAGE="http://gtkmm.sourceforge.net/"
SRC_URI="http://download.sourceforge.net/gtkmm/${P}.tar.gz"
#	 ftp://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz
#	 http://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1.2"
KEYWORDS="x86 ppc sparc hppa amd64 alpha ia64"
IUSE="debug"

DEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/libsigc++-1.0*"

src_unpack() {
	unpack ${A}

	# this patch applies only to gtkmm-1.2.9. gtkmm has been fixed
	# in CVS. It fixes a build problem with gcc3.1.
	# (http://marc.theaimsgroup.com/?l=gtkmm&m=101879848701486&w=2)
	epatch ${FILESDIR}/gtkmm-1.2.9-gcc3.1-gentoo.patch
}

src_compile() {
	local myconf
	[ `use debug` ] \
		&& myconf="--enable-debug=yes" \
		|| myconf="--enable-debug=no"
	econf \
		--sysconfdir=/etc/X11 \
		--with-xinput=xfree \
		--with-x \
		${myconf} || die

	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
