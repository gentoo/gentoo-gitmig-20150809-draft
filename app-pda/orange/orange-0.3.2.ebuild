# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/orange/orange-0.3.2.ebuild,v 1.1 2008/11/13 06:31:16 mescalinum Exp $

DESCRIPTION="A tool and library for extracting cabs from executable installers."
HOMEPAGE="http://synce.sourceforge.net/synce/orange.php"
SRC_URI="mirror://sourceforge/synce/lib${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=app-pda/synce-libsynce-0.9.1
		>=app-pda/dynamite-0.1.1
		>=app-arch/unshield-0.5.1"

S="${WORKDIR}/lib${P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_install() {
	econf || die
	emake DESTDIR="${D}" install || die
}
