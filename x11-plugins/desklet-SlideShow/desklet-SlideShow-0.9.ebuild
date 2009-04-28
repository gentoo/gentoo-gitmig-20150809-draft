# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-SlideShow/desklet-SlideShow-0.9.ebuild,v 1.1 2009/04/28 01:15:34 nixphoeni Exp $

DESKLET_NAME="${PN#desklet-}"

inherit gdesklets

DESCRIPTION="Slideshow desklet for gDesklets that cycles through a collection of pictures"
HOMEPAGE="http://gdesklets.de/index.php?q=desklet/view/221"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="${RDEPEND} >=x11-plugins/desklet-ImageSlideShow-0.8"
DOCS="todo"
