# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineakconfig/lineakconfig-0.4.1b-r2.ebuild,v 1.1 2006/04/10 20:54:22 smithj Exp $

inherit eutils

IUSE="nls"

DESCRIPTION="Linux support for Easy Access and Internet Keyboards features X11 support"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"

RDEPEND="x11-misc/lineakd
	=x11-libs/gtk+-1.2*"

DEPEND="nls? ( sys-devel/gettext )
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/lineakconfig-${PV}-malloc.patch
	cd ${S}
	sed -e "s|doc/"${PN}"|share/doc/"${P}"|g" -i Makefile.in || die
}

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die
}
