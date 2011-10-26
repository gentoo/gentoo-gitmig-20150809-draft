# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libclastfm/libclastfm-0.4.ebuild,v 1.1 2011/10/26 18:02:15 ssuominen Exp $

EAPI=4

DESCRIPTION="An unofficial C-API to the last.fm web service"
HOMEPAGE="http://liblastfm.sourceforge.net/"
SRC_URI="mirror://sourceforge/liblastfm/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="net-misc/curl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS README )

src_prepare() {
	# Fix compability with recent curl
	sed -i -e '/<curl\/types.h>/d' src/{lastfm-priv.h,lfm_helper.{c,h}} || die
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	rm -f "${ED}"usr/lib*/${PN}.la
}
