# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-infosatepg/vdr-infosatepg-0.0.10.ebuild,v 1.1 2010/06/06 11:07:08 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR Plugin: Reads the contents of infosat and writes the data into the EPG."
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-infosatepg"
SRC_URI="http://projects.vdr-developer.org/attachments/download/163/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
