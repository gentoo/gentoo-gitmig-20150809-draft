# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/yasr/yasr-0.6.7.ebuild,v 1.3 2008/06/27 02:59:23 williamh Exp $

DESCRIPTION="general-purpose console screen reader"
HOMEPAGE="http://yasr.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=sys-devel/autoconf-2.58"
RDEPEND=""

src_unpack(){
	unpack ${A}
	cd "${S}"
	sed -i '/^aclocaldir.*=/s:@aclocaldir@:$(destdir)/usr/share/aclocal:' "${S}"/m4/Makefile.*
}

src_compile() {
	econf --datadir='/etc' || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README ChangeLog AUTHORS BUGS CREDITS
	rm -rf "${D}"/usr/share/aclocal
}
