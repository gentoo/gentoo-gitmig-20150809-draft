# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/httrack/httrack-3.44.1-r1.ebuild,v 1.2 2011/11/30 17:20:30 ssuominen Exp $

EAPI=4

inherit eutils

DESCRIPTION="HTTrack Website Copier, Open Source Offline Browser"
HOMEPAGE="http://www.httrack.com/"
SRC_URI="http://download.httrack.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="static-libs"

RDEPEND=">=sys-libs/zlib-1.2.5.1-r1"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}+zlib-1.2.5.1.patch
}

src_configure() {
	econf \
		$(use_enable static-libs static)
}

src_compile() {
	emake -j1
}

DOCS=( AUTHORS README greetings.txt history.txt )
