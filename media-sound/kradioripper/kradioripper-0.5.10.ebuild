# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kradioripper/kradioripper-0.5.10.ebuild,v 1.1 2009/11/09 18:24:55 ssuominen Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="A program for ripping internet radios"
HOMEPAGE="http://kradioripper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-unstable-${PV}.unstable.tar.bz2"

LICENSE="GPL-2 GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="media-sound/streamripper"

S=${WORKDIR}/${PN}

DOCS="NEWS README TODO"
