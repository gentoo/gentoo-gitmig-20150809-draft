# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kradio/kradio-0.3.0_alpha2.ebuild,v 1.3 2004/03/15 20:39:45 centic Exp $

inherit kde-base
need-kde 3

S=${WORKDIR}/${P/_al/-al}

MY_PATCH="ksimus-patch-0.3.6-2"
DESCRIPTION="kradio is a radio tuner application for KDE"
HOMEPAGE="http://kradio.sourceforge.net/"
KEYWORDS="~x86"
SRC_URI="mirror://sourceforge/${PN}/${P/_al/-al}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="lirc"

DEPEND="lirc? ( app-misc/lirc )
	media-libs/libsndfile"

