# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbpanel/fbpanel-4.3.ebuild,v 1.6 2006/12/04 01:27:55 omp Exp $

inherit toolchain-funcs

DESCRIPTION="fbpanel is a light-weight X11 desktop panel"
HOMEPAGE="http://fbpanel.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '/^CFLAGS/d;/^CC/d' Makefile.common
}

src_compile() {
	# econf not happy here
	./configure --prefix=/usr || die "Configure failed."
	emake CHATTY=1 CC=$(tc-getCC) || die "Make failed."
}

src_install () {
	emake install PREFIX="${D}/usr" || die
	dodoc README CREDITS CHANGELOG
}
