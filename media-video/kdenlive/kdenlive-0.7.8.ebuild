# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kdenlive/kdenlive-0.7.8.ebuild,v 1.4 2011/02/02 05:06:54 tampakrap Exp $

EAPI=3
KDE_LINGUAS="ca cs da de el es fi fr gl he hr hu it nl pl pt pt_BR ru sl tr uk
zh"
inherit kde4-base

DESCRIPTION="Kdenlive! (pronounced Kay-den-live) is a Non Linear Video Editing Suite for KDE."
HOMEPAGE="http://www.kdenlive.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-linux"
IUSE="debug semantic-desktop"

RDEPEND="
	>=media-libs/mlt-0.5.10[ffmpeg,sdl,xml,melt,qt4,kde]
	media-video/ffmpeg[X,sdl]
	$(add_kdebase_dep kdelibs 'semantic-desktop?')
"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS README )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop Nepomuk)
	)

	kde4-base_src_configure
}
