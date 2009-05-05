# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cclive/cclive-0.4.1.ebuild,v 1.1 2009/05/05 21:22:39 vapier Exp $

inherit eutils

DESCRIPTION="Command line tool for extracting videos from various websites"
HOMEPAGE="http://code.google.com/p/cclive/"
SRC_URI="http://cclive.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=net-misc/curl-7.18.0"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-64bit.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
