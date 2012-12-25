# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dotconf/dotconf-1.3.ebuild,v 1.9 2012/12/25 11:09:16 maekke Exp $

EAPI="3"

inherit eutils

DESCRIPTION="dot.conf configuration file parser"
HOMEPAGE="http://www.github.com/williamh/dotconf"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
IUSE=""
DEPEND=">=sys-devel/autoconf-2.58"
RDEPEND=""

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}

pkg_postinst() {
	ewarn 'This version requires that you run revdep-rebuild after'
	ewarn 'the upgrade.'
}
