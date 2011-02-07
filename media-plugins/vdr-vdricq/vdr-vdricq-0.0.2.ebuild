# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vdricq/vdr-vdricq-0.0.2.ebuild,v 1.2 2011/02/07 00:03:10 hd_brummy Exp $

EAPI="3"

inherit eutils vdr-plugin

DESCRIPTION="Video Disk Recorder ICQ Plugin"
HOMEPAGE="http://vdr.computer-wiki.de/vdricq/
		http://www.vdr-wiki.de/wiki/index.php/Vdricq-plugin"
SRC_URI="http://vdr.computer-wiki.de/vdricq/${P}.tgz
		mirror://vdrfiles/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-libs/libicq2000"
RDEPEND="${DEPEND}"

S=${WORKDIR}/vdricq
