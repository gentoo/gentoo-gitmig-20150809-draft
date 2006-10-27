# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineakconfig/lineakconfig-0.4.1b-r2.ebuild,v 1.2 2006/10/27 06:53:59 omp Exp $

inherit eutils

DESCRIPTION="Linux support for Easy Access and Internet Keyboards features X11 support"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="nls"

RDEPEND="x11-misc/lineakd
	=x11-libs/gtk+-1.2*"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/lineakconfig-${PV}-malloc.patch"
	cd "${S}"
	sed -e "s|doc/"${PN}"|share/doc/"${P}"|g" -i Makefile.in || die
}

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
