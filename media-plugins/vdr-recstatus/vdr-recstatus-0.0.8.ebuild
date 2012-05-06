# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-recstatus/vdr-recstatus-0.0.8.ebuild,v 1.2 2012/05/06 19:39:19 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: displays the recording status of the available devices."
HOMEPAGE="http://www.constabel.net/projects/recstatus/wiki"
SRC_URI="https://www.constabel.net/files/vdr/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.6"

RDEPEND="${DEPEND}"
