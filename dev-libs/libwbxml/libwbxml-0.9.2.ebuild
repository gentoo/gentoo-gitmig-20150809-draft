# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libwbxml/libwbxml-0.9.2.ebuild,v 1.2 2006/09/03 09:16:39 hansmi Exp $

inherit eutils

IUSE=""

MY_P="wbxml2-${PV}"

DESCRIPTION="Library and tools to parse, encode and handle WBXML documents."
HOMEPAGE="http://libwbxml.aymerick.com/"
SRC_URI="mirror://sourceforge/wbxmllib/${MY_P}.tar.gz"

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

	cd ${S}

	# Remove ./configure stuff from the bootstrap script, 
	# we will handle that step directly
	subst="./configure --prefix=/usr"
	sed -i -e "s:${subst}:#${subst}:" bootstrap

	# Remove doc stuff from Makefile.am, otherwise make install complains
	epatch ${FILESDIR}/${MY_P}.make_install.patch

	# Add support for our own CFLAGS
	sed -i -e "s:-O3\\\:${CFLAGS}:"   src/Makefile.am
	sed -i -e "s:	 -g::"            src/Makefile.am
	sed -i -e "s:-O3\\\:${CFLAGS}:" tools/Makefile.am
	sed -i -e "s:	 -g::"          tools/Makefile.am

	chmod 755 bootstrap
}

src_compile()
{
	./bootstrap

	econf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install()
{
	einstall || die "Installation failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README References THANKS TODO
}
