# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/orange/orange-0.2-r1.ebuild,v 1.3 2004/04/25 22:31:27 agriffis Exp $

DESCRIPTION="Orange is a tool and library for squeezing out juicy \
installable Microsoft Cabinet Files from self-extracting installers \
for Microsoft Windows"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-pda/dynamite
		app-arch/unshield"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README
}
