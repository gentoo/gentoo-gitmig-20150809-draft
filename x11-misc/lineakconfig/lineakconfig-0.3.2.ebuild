# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineakconfig/lineakconfig-0.3.2.ebuild,v 1.3 2004/01/03 18:29:39 port001 Exp $

IUSE="nls"

DESCRIPTION="Linux support for Easy Access and Internet Keyboards features X11 support"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="=x11-libs/gtk+-1.2*
	sys-devel/gettext"

RDEPEND="x11-misc/lineakd
	=x11-libs/gtk+-1.2*"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die
}
