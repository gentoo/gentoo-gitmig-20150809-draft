# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rtf2html/rtf2html-0.2.0.ebuild,v 1.1 2008/03/17 10:57:23 s4t4n Exp $

IUSE=""

DESCRIPTION="RTF to HTML converter."
HOMEPAGE="http://rtf2html.sourceforge.net/"
SRC_URI="mirror://sourceforge/rtf2html/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile()
{
	econf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README
}
