# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineakconfig/lineakconfig-0.3.2.ebuild,v 1.7 2004/06/24 22:27:33 agriffis Exp $

IUSE="nls"

DESCRIPTION="Linux support for Easy Access and Internet Keyboards features X11 support"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="x11-misc/lineakd
	=x11-libs/gtk+-1.2*"

DEPEND="nls? ( sys-devel/gettext )
	${RDEPEND}"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die
}
