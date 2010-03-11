# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libwbxml/libwbxml-0.9.2_p48.ebuild,v 1.7 2010/03/11 14:52:05 s4t4n Exp $

inherit eutils autotools

IUSE=""

MY_P="wbxml2-${PV%%_p*}+svn49synce"

DESCRIPTION="Library and tools to parse, encode and handle WBXML documents."
HOMEPAGE="http://libwbxml.aymerick.com/"
SRC_URI="mirror://sourceforge/synce/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=dev-libs/expat-1.95.8"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack()
{
	unpack ${A}
	cd "${S}"

	# Remove doc stuff from Makefile.am, otherwise make install complains
	epatch "${FILESDIR}/wbxml2-${PV}.make_install.patch"

	# Don't rewrite use CFLAGS, pass everything as AM_CFLAGS instead.
	sed -i \
		-e '/-\(O3\|g\)/d' \
		-e '/-Wall/s:\\::' \
		-e 's:CFLAGS:AM_CFLAGS:' \
		{src,tools}/Makefile.am

	eautoreconf
}

src_install()
{
	einstall || die "Installation failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README References THANKS TODO
}
