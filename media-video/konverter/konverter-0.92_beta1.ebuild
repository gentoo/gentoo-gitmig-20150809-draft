# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/konverter/konverter-0.92_beta1.ebuild,v 1.2 2005/05/12 22:11:35 greg_g Exp $

inherit kde

DESCRIPTION="A KDE MEncoder frontend for video-conversion."
HOMEPAGE="http://www.kraus.tk/projects/konverter/"
SRC_URI="http://www.kraus.tk/projects/${PN}/sources/${P/_/-}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

S=${WORKDIR}/${P/_/-}

DEPEND="media-libs/xine-lib
	media-video/mplayer"

need-kde 3
