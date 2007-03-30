# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unshield/unshield-0.5-r1.ebuild,v 1.3 2007/03/30 02:56:31 beandog Exp $

inherit eutils

DESCRIPTION="InstallShield CAB file extractor."
HOMEPAGE="http://synce.sourceforge.net/synce/unshield.php"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc x86"
IUSE=""

DEPEND=">=sys-libs/zlib-1.1.4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-amd64.patch"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README
}
