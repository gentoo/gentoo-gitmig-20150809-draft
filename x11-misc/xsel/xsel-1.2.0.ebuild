# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsel/xsel-1.2.0.ebuild,v 1.2 2010/01/10 18:39:36 fauli Exp $

DESCRIPTION="XSel is a command-line program for getting and setting the contents of the X selection."
HOMEPAGE="http://www.vergenet.net/~conrad/software/xsel"
SRC_URI="http://www.vergenet.net/~conrad/software/${PN}/download/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-libs/libXt"

src_compile() {
	econf --disable-dependency-tracking
	emake CFLAGS="${CFLAGS}" || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README
}
