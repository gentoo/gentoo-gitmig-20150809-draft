# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kradio/kradio-0.3.0_alpha2.ebuild,v 1.7 2004/11/23 05:42:18 eradicator Exp $

IUSE="lirc"

inherit kde

S=${WORKDIR}/${P/_al/-al}

DESCRIPTION="kradio is a radio tuner application for KDE"
HOMEPAGE="http://kradio.sourceforge.net/"
SRC_URI="mirror://sourceforge/kradio/${P/_al/-al}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~sparc ~x86"

DEPEND="lirc? ( app-misc/lirc )
	media-libs/libsndfile"
need-kde 3

MY_PATCH="ksimus-patch-0.3.6-2"
