# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libisofs/libisofs-0.2.4.ebuild,v 1.6 2008/04/13 18:49:40 drac Exp $

DESCRIPTION="libisofs is an open-source library for reading, mastering and writing optical discs."
HOMEPAGE="http://libburnia.pykix.org/"
SRC_URI="http://libburnia-download.pykix.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-libs/libburn-0.2.6.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS CONTRIBUTORS README doc/comments
}
