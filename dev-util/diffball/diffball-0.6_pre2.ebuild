# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/diffball/diffball-0.6_pre2.ebuild,v 1.2 2004/09/17 10:47:10 ferringb Exp $

IUSE=""

DESCRIPTION="Delta compression suite for using/generating binary patches"
HOMEPAGE="http://sourceforge.net/projects/diffball"
SRC_URI="mirror://sourceforge/diffball/diffball-${PV}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc alpha ~hppa ~mips ~amd64 ~ia64"

DEPEND=">=dev-libs/openssl-0.9.6j
	>=dev-libs/popt-1.7
	>=sys-libs/zlib-1.1.4
	>=app-arch/bzip2-1.0.2"

src_compile() {
	econf $(use_enable debug asserts) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	cd ${S}
	einstall || die

	dodoc AUTHORS ChangeLog README TODO
}
