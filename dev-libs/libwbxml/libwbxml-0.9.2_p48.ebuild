# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libwbxml/libwbxml-0.9.2_p48.ebuild,v 1.5 2009/01/15 08:44:06 s4t4n Exp $

IUSE=""

MY_P="wbxml2-${PV%%_p*}+svn49synce"

DESCRIPTION="Library and tools to parse, encode and handle WBXML documents."
HOMEPAGE="http://libwbxml.aymerick.com/"
SRC_URI="mirror://sourceforge/synce/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=dev-libs/expat-1.95.8"

S="${WORKDIR}/${MY_P}"

src_install()
{
	einstall || die "Installation failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README References THANKS TODO
}
