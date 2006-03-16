# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/orange/orange-0.3.ebuild,v 1.2 2006/03/16 18:13:56 sekretarz Exp $

DESCRIPTION="A tool and library for extracting cabs from executable installers."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=app-pda/dynamite-0.1
		>=app-arch/unshield-0.5
		>=app-pda/synce-librapi2-0.9.1
		>=app-pda/synce-libsynce-0.9.1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:-Werror::" lib/Makefile.am
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README
}
