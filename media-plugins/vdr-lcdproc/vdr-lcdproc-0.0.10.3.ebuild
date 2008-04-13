# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-lcdproc/vdr-lcdproc-0.0.10.3.ebuild,v 1.1 2008/04/13 20:11:49 hd_brummy Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: use LCD device for additional output"
HOMEPAGE="http://www.joachim-wilke.de/?alias=vdr-patches&lang=en"
SRC_URI="mirror://vdrfiles/${PN}/${PN}-0.0.10-jw3.tgz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.5.17
		>=app-misc/lcdproc-0.4.3"

S=${WORKDIR}/lcdproc-0.0.10-jw3
