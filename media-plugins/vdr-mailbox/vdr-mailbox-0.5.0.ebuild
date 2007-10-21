# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-mailbox/vdr-mailbox-0.5.0.ebuild,v 1.1 2007/10/21 20:13:59 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: MailBox"
HOMEPAGE="http://sites.inka.de/seca/vdr"
SRC_URI="http://sites.inka.de/seca/vdr/download/${P}.tgz
		mirror://vdrfiles/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.8
		>=net-libs/c-client-2002e-r1"

src_unpack() {
	vdr-plugin_src_unpack

	sed -i Makefile -e "s:^#CXXFLAGS ?=:CXXFLAGS ?=:"
}
