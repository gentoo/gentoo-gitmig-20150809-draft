# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkmm/gtkmm-2.0.2.ebuild,v 1.5 2003/03/11 21:11:49 seemant Exp $

S=${WORKDIR}/${P}
IUSE=""
DESCRIPTION="C++ interface for GTK+2"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc ~sparc "

SLOT="2"
DEPEND="virtual/glibc
	>=dev-lang/perl-5.6.0
	=dev-libs/glib-2.0*
	=x11-libs/gtk+-2.0*
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




