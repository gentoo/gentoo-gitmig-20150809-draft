# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libmath++/libmath++-0.0.4.ebuild,v 1.2 2004/12/05 08:40:10 vapier Exp $

DESCRIPTION="template based math library, written in C++, for symbolic and numeric calculus applications"
HOMEPAGE="http://www.surakware.net/projects/libmath++/index.xml"
SRC_URI="http://upstream.trapni-akane.org/libmath%2B%2B/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~ppc ~s390 x86"
IUSE=""

DEPEND=">=sys-devel/autoconf-2.59-r5
	>=sys-devel/automake-1.8.5-r1"
RDEPEND=""

src_compile() {
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7
	autoreconf -v --install

	econf || die "configure failed"
	emake || die "make filed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README TODO
}
