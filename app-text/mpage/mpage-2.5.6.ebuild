# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mpage/mpage-2.5.6.ebuild,v 1.1 2010/08/31 00:01:39 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Many to one page printing utility"
HOMEPAGE="http://www.mesa.nl/"
SRC_URI="http://www.mesa.nl/pub/${PN}/${P}.tgz"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="freedist"
SLOT="0"
IUSE=""

src_prepare() {
	sed -i Makefile \
		-e '/^CFLAGS/s|=.*| += $(DEFS)|g' \
		-e 's|$(CFLAGS) -o|$(LDFLAGS) &|g' \
		|| die "sed Makefile"
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		PREFIX=/usr \
		MANDIR=/usr/share/man/man1 \
		|| die "emake failed"
}

src_install () {
	emake \
		PREFIX="${D}/usr" \
		MANDIR="${D}/usr/share/man/man1" install || die "make install failed"
	dodoc CHANGES Encoding.format FAQ NEWS README TODO || die "dodoc failed"
}
