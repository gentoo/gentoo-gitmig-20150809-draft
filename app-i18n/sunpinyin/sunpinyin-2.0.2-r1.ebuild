# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/sunpinyin/sunpinyin-2.0.2-r1.ebuild,v 1.1 2011/01/08 06:13:50 qiaomuf Exp $

EAPI="1"
PYTHON_DEPEND="ibus? 2:2.5"
inherit eutils python scons-utils

DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://sunpinyin.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}.tar.gz"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ibus +xim"

RDEPEND="dev-db/sqlite:3
	ibus? (
		>=app-i18n/ibus-1.1
		!app-i18n/ibus-sunpinyin
		sys-devel/gettext
	)
	xim? (
		>=x11-libs/gtk+-2.10:2
		x11-libs/libX11
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	xim? ( x11-proto/xproto )"
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-ldflags.patch"
}

src_compile() {
	escons --prefix="/usr"
}

src_install() {
	escons --prefix="/usr" --install-sandbox="${D}" install
	if use ibus; then
		cd "${S}/wrapper/ibus"
		escons --prefix="/usr" --install-sandbox="${D}" install
	elif use xim; then
		cd "${S}/wrapper/xim"
		escons --prefix="/usr" --install-sandbox="${D}" install
	fi
}
