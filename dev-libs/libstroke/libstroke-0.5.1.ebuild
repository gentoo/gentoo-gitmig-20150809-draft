# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libstroke/libstroke-0.5.1.ebuild,v 1.11 2004/07/31 01:53:53 tgall Exp $

inherit gnuconfig

DESCRIPTION="A Stroke and Guesture recognition Library"
SRC_URI="http://www.etla.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.etla.net/libstroke"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha ppc amd64 ppc64"
IUSE=""

DEPEND=">=sys-libs/glibc-2.1.3
	>=x11-libs/gtk+-1.2.10
	virtual/x11"

src_compile() {
	gnuconfig_update

	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYING COPYRIGHT CREDITS ChangeLog README
}
