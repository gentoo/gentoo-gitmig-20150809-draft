# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/gtk-splitter/gtk-splitter-2.2.ebuild,v 1.8 2005/03/18 00:39:04 vapier Exp $

DESCRIPTION="split/combine files !"
HOMEPAGE="http://gtk-splitter.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="crypt"

RDEPEND=">=x11-libs/gtk+-2
	crypt? ( >=app-crypt/mhash-0.8 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12"

src_compile() {
	econf || die
	if ! use crypt ; then
		# stupid configure script only autodetects
		sed -i \
			-e 's:-lmhash::' \
			-e 's:-DHAVE_LIBMHASH=1::' \
			src/Makefile
	fi
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
