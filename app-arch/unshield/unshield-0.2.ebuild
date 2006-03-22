# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unshield/unshield-0.2.ebuild,v 1.8 2006/03/22 04:30:38 wolf31o2 Exp $

DESCRIPTION="InstallShield CAB file extractor."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=sys-libs/zlib-1.1.4"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README
}
