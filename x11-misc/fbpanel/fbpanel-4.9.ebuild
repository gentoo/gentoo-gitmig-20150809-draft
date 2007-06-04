# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbpanel/fbpanel-4.9.ebuild,v 1.1 2007/06/04 04:49:32 omp Exp $

inherit toolchain-funcs

DESCRIPTION="fbpanel is a light-weight X11 desktop panel"
HOMEPAGE="http://fbpanel.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Will be fixed in 4.10.
	sed -i \
		-e '41s/$(LIBS) $(OBJ) $(EXTRAOBJ)/$(OBJ) $(EXTRAOBJ) $(LIBS)/' \
		Makefile || die "sed failed"
}

src_compile() {
	# econf does not work.
	./configure --prefix=/usr || die "configure failed"
	emake CHATTY=1 CC=$(tc-getCC) || die "emake failed"
}

src_install () {
	emake PREFIX="${D}/usr" install || die "emake install failed"
	dodoc CHANGELOG CREDITS README
}
