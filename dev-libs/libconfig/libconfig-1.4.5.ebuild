# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libconfig/libconfig-1.4.5.ebuild,v 1.1 2010/07/09 00:41:56 jer Exp $

EAPI="2"

DESCRIPTION="Libconfig is a simple library for manipulating structured configuration files"
HOMEPAGE="http://www.hyperrealm.com/libconfig/libconfig.html"
SRC_URI="http://www.hyperrealm.com/libconfig/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="
	sys-devel/libtool
	sys-devel/bison"
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
