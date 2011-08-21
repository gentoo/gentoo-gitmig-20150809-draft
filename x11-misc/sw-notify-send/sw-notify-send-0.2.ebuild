# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/sw-notify-send/sw-notify-send-0.2.ebuild,v 1.1 2011/08/21 21:22:45 mgorny Exp $

EAPI=4
inherit autotools-utils

MY_PN=tinynotify-send
MY_P=${MY_PN}-${PV}

DESCRIPTION="A system-wide variant of tinynotify-send"
HOMEPAGE="https://github.com/mgorny/tinynotify-send/"
SRC_URI="http://cloud.github.com/downloads/mgorny/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libtinynotify
	x11-libs/libtinynotify-cli
	x11-libs/libtinynotify-systemwide"
DEPEND="${RDEPEND}"

DOCS=( README )
S=${WORKDIR}/${MY_P}

src_configure() {
	myeconfargs=(
		--disable-regular
		--enable-system-wide
	)

	autotools-utils_src_configure
}
