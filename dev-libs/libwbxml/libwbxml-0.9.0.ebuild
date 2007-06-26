# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libwbxml/libwbxml-0.9.0.ebuild,v 1.4 2007/06/26 01:53:49 mr_bones_ Exp $

inherit eutils

IUSE="nokia6600"

MY_P="wbxml2-${PV}"

DESCRIPTION="Library and tools to parse, encode and handle WBXML documents."
HOMEPAGE="http://libwbxml.aymerick.com/"
SRC_URI="mirror://sourceforge/wbxmllib/${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"

DEPEND=">=sys-apps/sed-4.1.4"

S="${WORKDIR}/${MY_P}"

src_unpack()
{
	unpack ${A}

	cd ${S}

	# Add optional Nokia 6600 support
	use nokia6600 && epatch ${FILESDIR}/${MY_P}.nokia-6600.patch

	# Remove ./configure stuff from the bootstrap script,
	# we will handle that step directly
	subst="./configure --prefix=/usr"
	sed -i -e "s:${subst}:#${subst}:" bootstrap

	# Add support for our own CFLAGS
	sed -i -e "s:-O3\\\:${CFLAGS}:"   src/Makefile.am
	sed -i -e "s:	 -g::"            src/Makefile.am
	sed -i -e "s:-O3\\\:${CFLAGS}:" tools/Makefile.am
	sed -i -e "s:	 -g::"          tools/Makefile.am
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
}
