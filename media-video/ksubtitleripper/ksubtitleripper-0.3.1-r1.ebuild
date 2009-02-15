# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ksubtitleripper/ksubtitleripper-0.3.1-r1.ebuild,v 1.1 2009/02/15 17:34:32 carlo Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="A graphical frontend to subtitleripper."
HOMEPAGE="http://ksubtitleripper.berlios.de/"
SRC_URI="mirror://berlios/ksubtitleripper/${P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="media-video/subtitleripper"

need-kde 3.5

PATCHES=(
	"${FILESDIR}/ksubtitleripper-0.3.1-desktop-file.diff"
	)
