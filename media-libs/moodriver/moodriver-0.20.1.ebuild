# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/moodriver/moodriver-0.20.1.ebuild,v 1.2 2007/01/01 04:05:44 chutzpah Exp $

DESCRIPTION="C++ class to interact with museekd."
HOMEPAGE="http://projects.beep-media-player.org/index.php/Main/Moodriver"
SRC_URI="http://files.beep-media-player.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libsigc++"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

