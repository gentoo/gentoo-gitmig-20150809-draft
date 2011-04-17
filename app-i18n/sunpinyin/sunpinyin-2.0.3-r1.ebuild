# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/sunpinyin/sunpinyin-2.0.3-r1.ebuild,v 1.2 2011/04/17 09:03:04 qiaomuf Exp $

EAPI="1"
inherit eutils scons-utils

DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://sunpinyin.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}.tar.gz
		http://open-gram.googlecode.com/files/dict.utf8.tar.bz2
		http://open-gram.googlecode.com/files/lm_sc.t3g.arpa.tar.bz2"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-db/sqlite:3"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_unpack() {
	unpack "${P}.tar.gz"
	ln -s "${DISTDIR}/dict.utf8.tar.bz2" "${S}/raw/" || die "dict file not found"
	ln -s "${DISTDIR}/lm_sc.t3g.arpa.tar.bz2" "${S}/raw/" || die "dict file not found"
	cd "${S}" && epatch "${FILESDIR}/${P}-force-switch.patch"
}

src_compile() {
	escons --prefix="/usr" || die
}

src_install() {
	escons --prefix="/usr" --install-sandbox="${D}" install || die
}

pkg_postinst() {
	elog ""
	elog "If you have already installed former version of ${PN}"
	elog "and any wrapper, please remerge the wrapper to make it work with"
	elog "the new version."
	elog ""
	elog "To use any wrapper for ${PN}, please merge any of the following"
	elog "packages: "
	elog "emerge app-i18n/fcitx-sunpinyin"
	elog "emerge app-i18n/ibus-sunpinyin"
	elog "emerge app-i18n/scim-sunpinyin"
	elog "emerge app-i18n/xsunpinyin"
	elog ""
}
