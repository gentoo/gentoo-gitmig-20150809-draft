# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpasman/wmpasman-0.8.4.1.ebuild,v 1.8 2006/10/10 09:12:20 s4t4n Exp $

IUSE=""

DESCRIPTION="Password storage/retrieval in a dockapp"
HOMEPAGE="http://sourceforge.net/projects/wmpasman/"
SRC_URI="mirror://sourceforge/wmpasman/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc ~sparc"

RDEPEND=">=x11-libs/gtk+-2.4.1
	>=app-crypt/mhash-0.9.1
	>=app-crypt/mcrypt-2.6.4"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	>=dev-util/pkgconfig-0.20
	>=x11-libs/libXpm-3.5.5"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# Solves compile error about undefined exit - Bug 140857
	sed -i -e '/#include <stdio.h>/ { p ; s/stdio/stdlib/ }' wmgeneral/wmgeneral-gtk.c
}

src_install()
{
	einstall
	dodoc BUGS ChangeLog README TODO WARNINGS
}

pkg_postinst()
{
	ewarn "Please read the WARNINGS file."
}
