# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gpodder/gpodder-0.9.0.ebuild,v 1.1 2007/04/02 22:30:57 hanno Exp $

inherit distutils

DESCRIPTION="gPodder is a Podcast receiver/catcher written in Python, using GTK."
HOMEPAGE="http://gpodder.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipod"
RESTRICT="test"

DEPEND="dev-python/pygtk
	dev-python/pyxml
	ipod? (
		dev-python/eyeD3
		media-libs/libgpod
	)"
