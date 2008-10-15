# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cpdvd/cpdvd-1.10-r1.ebuild,v 1.1 2008/10/15 11:54:41 flameeyes Exp $

EAPI=2

IUSE=""

S="${WORKDIR}"

DESCRIPTION="transfer a DVD title to your harddisk with ease on Linux"
HOMEPAGE="http://www.lallafa.de/bp/cpdvd.html"
SRC_URI="http://www.lallafa.de/bp/files/${P}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=""

RDEPEND=">=media-video/transcode-0.6.2[dvdread]
	>=dev-lang/perl-5.8.0-r12
	>=media-video/cpvts-1.2"

src_install () {
	newbin ${P} ${PN} || die
}
