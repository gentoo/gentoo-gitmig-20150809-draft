# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gpodder/gpodder-0.7.ebuild,v 1.1 2006/06/28 20:12:01 hanno Exp $

inherit distutils

DESCRIPTION="gPodder is a Podcast receiver/catcher written in Python, using GTK."
HOMEPAGE="http://perli.net/projekte/gpodder/"
SRC_URI="http://perli.net/projekte/${PN}/releases/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ipod"

DEPEND="dev-python/pygtk
	dev-python/pyxml
	ipod? (
		dev-python/eyeD3
		media-libs/libgpod
	)"
