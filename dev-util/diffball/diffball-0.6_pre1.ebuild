# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/diffball/diffball-0.6_pre1.ebuild,v 1.1 2004/08/30 02:06:06 ferringb Exp $

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

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog README TODO
}
