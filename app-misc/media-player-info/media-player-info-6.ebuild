# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/media-player-info/media-player-info-6.ebuild,v 1.1 2010/04/12 20:07:28 pacho Exp $

EAPI="2"

DESCRIPTION="Repository of data files describing media player capabilities."
HOMEPAGE="http://cgit.freedesktop.org/media-player-info/"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-fs/udev-145[extras]"
RDEPEND="${DEPEND}"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodocs failed"
}
