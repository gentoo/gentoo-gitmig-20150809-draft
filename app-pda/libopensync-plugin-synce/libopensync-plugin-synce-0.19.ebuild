# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-synce/libopensync-plugin-synce-0.19.ebuild,v 1.1 2006/10/23 19:46:38 peper Exp $

DESCRIPTION="OpenSync Synce Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

DEPEND=">=app-pda/libopensync-0.19
	app-pda/synce-rra
	dev-libs/libmimedir"

RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING NEWS README
}
