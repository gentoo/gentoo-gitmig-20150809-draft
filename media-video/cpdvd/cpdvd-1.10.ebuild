# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cpdvd/cpdvd-1.10.ebuild,v 1.8 2006/07/04 05:19:43 squinky86 Exp $

inherit eutils

IUSE=""

S="${WORKDIR}"

DESCRIPTION="transfer a DVD title to your harddisk with ease on Linux"
HOMEPAGE="http://www.lallafa.de/bp/cpdvd.html"
SRC_URI="http://www.lallafa.de/bp/files/${P}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~x86"

DEPEND=""

RDEPEND=">=media-video/transcode-0.6.2
	>=dev-lang/perl-5.8.0-r12
	>=media-video/cpvts-1.2"

pkg_setup() {
	built_with_use media-video/transcode dvdread || die "Transcode needs dvdread support builtin for this package to work."
}

src_compile () {
	einfo "Nothing to compile."
}

src_install () {
	newbin ${P} ${PN} || die
}
