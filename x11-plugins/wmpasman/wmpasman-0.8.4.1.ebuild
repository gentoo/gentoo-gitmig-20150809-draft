# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpasman/wmpasman-0.8.4.1.ebuild,v 1.3 2004/08/03 12:07:35 dholm Exp $

IUSE=""

DESCRIPTION="Password storage/retrieval in a dockapp"
HOMEPAGE="http://sourceforge.net/projects/wmpasman/"
SRC_URI="mirror://sourceforge/wmpasman/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"

DEPEND=">=x11-libs/gtk+-2.4.1
	>=app-crypt/mhash-0.9.1
	>=app-crypt/mcrypt-2.6.4"

src_install()
{
	einstall
	dodoc BUGS ChangeLog README TODO WARNINGS
}

pkg_postinst()
{
	ewarn "Please read the WARNINGS file."
}
