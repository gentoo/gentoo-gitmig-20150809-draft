# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kdenlive/kdenlive-0.7.6.ebuild,v 1.6 2009/11/29 15:01:26 josejx Exp $

EAPI=2

# No linguas since they add it weirdly.
#KDE_LINGUAS="ca cs da de es fr he hu it nl pt_BR ru sl zh"
inherit kde4-base eutils

DESCRIPTION="Kdenlive! (pronounced Kay-den-live) is a Non Linear Video Editing Suite for KDE."
HOMEPAGE="http://www.kdenlive.org/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=media-libs/mlt-0.4.6[ffmpeg,sdl,xml,melt,qt4,kde]
	media-video/ffmpeg[X,sdl]
	>=kde-base/kdelibs-${KDE_MINIMAL}[semantic-desktop]"

S=${WORKDIR}/${PN}-${PV/_/}
