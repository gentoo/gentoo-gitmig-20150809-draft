# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkmm/gtkmm-2.2.1.ebuild,v 1.2 2003/05/22 14:00:28 foser Exp $

inherit gnome.org

S=${WORKDIR}/${P}
IUSE=""
DESCRIPTION="C++ interface for GTK+2"
HOMEPAGE="http://gtkmm.sourceforge.net/"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc ~sparc"

SLOT="2"
DEPEND="virtual/glibc
	>=dev-lang/perl-5.6.0
	>=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	>=dev-libs/libsigc++-1.2"

src_compile() {
	local myconf
	
	if [ "${DEBUG}" ]
	then
		myconf="--enable-debug=yes"
	else
		myconf="--enable-debug=no"
	fi


	econf ${myconf} || die "econf failed"		
	emake || die "emake failed."
}

src_install() {
	einstall || die "install failed"

	dodoc AUTHORS CHANGES COPYING ChangeLog \
		HACKING PORTING NEWS README TODO
}




