# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kstreamripper/kstreamripper-0.7.0.ebuild,v 1.1 2010/05/18 17:24:18 ssuominen Exp $

EAPI=2
KDE_MINIMAL=4.4
inherit kde4-base

DESCRIPTION="A program for ripping internet radios"
HOMEPAGE="http://kstreamripper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=net-libs/libproxy-0.3.1"
RDEPEND="${DEPEND}
	media-sound/streamripper"

S=${WORKDIR}/${PN}

DOCS="ABOUT NEWS README TODO.odt"
