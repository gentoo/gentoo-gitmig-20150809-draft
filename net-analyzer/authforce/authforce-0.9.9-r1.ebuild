# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/authforce/authforce-0.9.9-r1.ebuild,v 1.1 2011/11/12 14:34:07 xmw Exp $

EAPI=4

inherit base

DESCRIPTION="An HTTP authentication brute forcer"
HOMEPAGE="http://www.divineinvasion.net/authforce"
SRC_URI="http://www.divineinvasion.net/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="curl nls"
DEPEND="sys-libs/readline
	nls? ( sys-devel/gettext )
	curl? ( net-misc/curl )"

DOCS=( AUTHORS BUGS NEWS README THANKS TODO )
PATCHES=( "${FILESDIR}"/${P}-curl.patch )

src_configure() {
	econf \
		$(use_with curl) \
		$(use_enable nls) \
		--with-path=/usr/share/${PN}/data:.
}
