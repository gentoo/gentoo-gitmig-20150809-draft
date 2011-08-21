# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tinynotify-send/tinynotify-send-0.2.ebuild,v 1.1 2011/08/21 21:18:50 mgorny Exp $

EAPI=4
inherit autotools-utils

DESCRIPTION="A notification sending utility (using libtinynotify)"
HOMEPAGE="https://github.com/mgorny/tinynotify-send/"
SRC_URI="http://cloud.github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="symlink"

RDEPEND="x11-libs/libtinynotify
	x11-libs/libtinynotify-cli
	symlink? ( !x11-libs/libnotify )"
DEPEND="${RDEPEND}"

DOCS=( README )

src_configure() {
	myeconfargs=(
		--enable-regular
		--disable-system-wide
		--with-system-wide-exec=/usr/bin/sw-notify-send
	)

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	use symlink && dosym tinynotify-send /usr/bin/notify-send
}
