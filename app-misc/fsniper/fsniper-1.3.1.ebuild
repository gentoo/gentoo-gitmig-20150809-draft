# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fsniper/fsniper-1.3.1.ebuild,v 1.3 2011/01/04 21:58:17 hwoarang Exp $

DESCRIPTION="Tool that monitors a given set of directories for new files"
HOMEPAGE="http://projects.l3ib.org/trac/fsniper"
SRC_URI="http://projects.l3ib.org/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/libpcre
	sys-apps/file"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog example.conf README || die
}
