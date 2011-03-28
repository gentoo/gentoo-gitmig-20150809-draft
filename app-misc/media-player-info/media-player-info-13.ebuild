# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/media-player-info/media-player-info-13.ebuild,v 1.1 2011/03/28 17:08:07 ssuominen Exp $

EAPI=4

DESCRIPTION="A repository of data files describing media player capabilities"
HOMEPAGE="http://cgit.freedesktop.org/media-player-info/"
SRC_URI="http://www.freedesktop.org/software/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-fs/udev-145[extras]"
DEPEND="${RDEPEND}"

RESTRICT="binchecks strip" # This ebuild doesn't install any binaries
