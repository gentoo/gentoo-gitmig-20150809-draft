# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbpanel/fbpanel-4.12.ebuild,v 1.1 2007/08/25 03:05:49 omp Exp $

inherit toolchain-funcs

DESCRIPTION="fbpanel is a light-weight X11 desktop panel"
HOMEPAGE="http://fbpanel.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	# econf does not work.
	./configure --prefix=/usr || die "configure failed"
	emake CHATTY=1 CC=$(tc-getCC) || die "emake failed"
}

src_install () {
	emake PREFIX="${D}/usr" install || die "emake install failed"
	dodoc CHANGELOG CREDITS README
}
