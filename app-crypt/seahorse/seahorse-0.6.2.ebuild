# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/seahorse/seahorse-0.6.2.ebuild,v 1.4 2003/04/12 15:45:40 liquidx Exp $

IUSE=""
DESCRIPTION="gnome front end to gnupg"
SRC_URI="mirror://sourceforge/seahorse/${P}.tar.gz"
HOMEPAGE="http://seahorse.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

DEPEND="virtual/x11
	>=app-crypt/gnupg-1.2.0
	=app-crypt/gpgme-0.3.14
	>=x11-libs/gtk+-2*
	>=gnome-base/libgnome-2*
	>=app-text/scrollkeeper-0.3*"

src_compile() {                           
	econf
	emake || die "parallel make failed"
}

src_install() {
	einstall
	dodoc AUTHORS COPYING* ChangeLog NEWS README TODO THANKS
}
