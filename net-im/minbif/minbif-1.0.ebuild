# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/minbif/minbif-1.0.ebuild,v 1.1 2009/11/24 19:22:35 cedk Exp $

EAPI=2

inherit cmake-utils

DESCRIPTION="an IRC gateway to IM networks"
HOMEPAGE="http://minbif.im/"
SRC_URI="http://symlink.me/attachments/download/30/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="libcaca gstreamer xinetd"

DEPEND=">=net-im/pidgin-2.6[gstreamer?]
	libcaca? ( media-libs/libcaca media-libs/imlib2 )"
RDEPEND="${DEPEND}
	virtual/logger
	xinetd? ( sys-apps/xinetd )"

src_prepare() {
	sed -i "s/-Werror//g" CMakeLists.txt || die "sed failed"

	sed -i "s#share/doc/minbif#share/doc/${P}#" \
		CMakeLists.txt || die "sed failed"

	if use xinetd; then
		sed -i "s/type\s=\s[0-9]/type = 0/" \
			minbif.conf || die "sed failed"
	fi
}

src_configure() {
	use gstreamer && ! use libcaca && \
		die "You need to enable libcaca if you enable gstreamer"

	local mycmakeargs
	mycmakeargs="${mycmakeargs}
		-DCONF_PREFIX=${PREFIX:-/etc/minbif}
		$(cmake-utils_use_enable libcaca CACA)
		$(cmake-utils_use_enable gstreamer VIDEO)"

	cmake-utils_src_configure
}

pkg_preinst() {
	enewgroup minbif
	enewuser minbif -1 -1 /var/lib/minbif minbif
}

src_install() {
	cmake-utils_src_install
	keepdir /var/lib/minbif
	fperms 700 /var/lib/minbif
	fowners minbif:minbif /var/lib/minbif

	dodoc ChangeLog README
	doman man/minbif.8

	if use xinetd; then
		insinto /etc/xinetd.d
		newins doc/minbif.xinetd minbif
	fi

	newinitd "${FILESDIR}"/minbif.initd minbif || die

	dodir /usr/share/minbif
	insinto /usr/share/minbif
	doins -r scripts
}
