# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tinynotify-send/tinynotify-send-1.2.1.ebuild,v 1.3 2012/05/05 04:53:52 jdhore Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="A notification sending utility (using libtinynotify)"
HOMEPAGE="https://github.com/mgorny/tinynotify-send/"
SRC_URI="mirror://github/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="symlink"

RDEPEND="x11-libs/libtinynotify
	~x11-libs/libtinynotify-cli-${PV}
	symlink? ( !x11-libs/libnotify[symlink] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( README )

src_configure() {
	myeconfargs=(
		--disable-library
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
