# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/fritzing/fritzing-0.7.4b.ebuild,v 1.1 2012/04/18 17:26:18 idl0r Exp $

EAPI=4

inherit qt4-r2

DESCRIPTION="Electronic Design Automation"
HOMEPAGE="http://fritzing.org/"
SRC_URI="http://fritzing.org/download/${PV}/source-tarball/${P}.source.tar.bz2"

LICENSE="CCPL-Attribution-ShareAlike-3.0 GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/zlib
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	x11-libs/qt-sql:4[sqlite]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}.source"
