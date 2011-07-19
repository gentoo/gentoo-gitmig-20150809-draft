# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/scmpc/scmpc-0.3.1.ebuild,v 1.3 2011/07/19 20:19:39 maekke Exp $

EAPI=4

DESCRIPTION="a client for MPD which submits your tracks to last.fm"
HOMEPAGE="http://cmende.github.com/scmpc/"
SRC_URI="https://github.com/downloads/cmende/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	dev-libs/confuse
	net-misc/curl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README scmpc.conf.example )

src_install() {
	default

	newinitd "${FILESDIR}"/${PN}-2.init ${PN}
	insinto /etc
	insopts -m600
	newins scmpc.conf.example scmpc.conf
}
