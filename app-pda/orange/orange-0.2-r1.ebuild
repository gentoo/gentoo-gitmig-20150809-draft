# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/orange/orange-0.2-r1.ebuild,v 1.6 2004/10/18 12:16:30 dholm Exp $

DESCRIPTION="Orange is a tool and library for squeezing out juicy \
installable Microsoft Cabinet Files from self-extracting installers \
for Microsoft Windows"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=app-pda/dynamite-0.1
		>=app-arch/unshield-0.2
		>=app-pda/synce-librapi2-0.8.9
		>=app-pda/synce-libsynce-0.8.9"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -ie "s:-Werror::" lib/Makefile.am
}

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README
}
