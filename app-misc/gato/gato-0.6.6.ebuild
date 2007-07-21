# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gato/gato-0.6.6.ebuild,v 1.6 2007/07/21 20:03:01 vapier Exp $

inherit autotools eutils

DESCRIPTION="An interface to the at UNIX command"
HOMEPAGE="http://www.arquired.es/users/aldelgado/proy/gato/"
SRC_URI="http://www.arquired.es/users/aldelgado/proy/gato/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1*
	sys-process/at"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-perms.patch
	cd "${S}"/src
	eautoreconf
}

src_compile() {
	cd src
	econf || die
	emake || die "emake failed"
}

src_install() {
	emake install.xpm PREFIX="${D}/usr" || die "install.xpm failed"
	chmod a-x "${D}"/usr/share/gato/* # fperms doesnt glob
	dodoc AUTHOR CHANGELOG README TODO
	cd src
	emake install DESTDIR="${D}" || die "install failed"
}
