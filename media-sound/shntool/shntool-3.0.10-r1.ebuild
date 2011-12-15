# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/shntool/shntool-3.0.10-r1.ebuild,v 1.4 2011/12/15 11:50:56 ago Exp $

DESCRIPTION="shntool is a multi-purpose WAVE data processing and reporting utility"
HOMEPAGE="http://shnutils.freeshell.org/shntool/"
SRC_URI="http://shnutils.freeshell.org/shntool/dist/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"
IUSE="alac flac mac shorten sox wavpack"

RDEPEND="flac? ( media-libs/flac )
	mac? ( media-sound/mac )
	sox? ( media-sound/sox )
	alac? ( media-sound/alac_decoder )
	shorten? ( media-sound/shorten )
	wavpack? ( media-sound/wavpack )"

DEPEND="${RDEPEND}"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc NEWS README ChangeLog AUTHORS doc/* || die
}
