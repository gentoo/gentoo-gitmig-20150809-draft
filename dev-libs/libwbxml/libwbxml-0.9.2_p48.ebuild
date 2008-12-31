# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libwbxml/libwbxml-0.9.2_p48.ebuild,v 1.3 2008/12/31 03:19:25 mr_bones_ Exp $

inherit eutils

IUSE=""

MY_P="wbxml2-${PV%%_p*}+svn49synce"

DESCRIPTION="Library and tools to parse, encode and handle WBXML documents."
HOMEPAGE="http://libwbxml.aymerick.com/"
SRC_URI="mirror://sourceforge/synce/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=dev-libs/expat-1.95.8"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4.1.4"

S="${WORKDIR}/${MY_P}"

src_unpack()
{
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_install()
{
	einstall || die "Installation failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README References THANKS TODO
}
