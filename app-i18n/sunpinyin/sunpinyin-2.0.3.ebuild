# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/sunpinyin/sunpinyin-2.0.3.ebuild,v 1.1 2011/02/20 05:02:38 qiaomuf Exp $

EAPI="1"
inherit scons-utils

MY_P=${P/_/-}

DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://sunpinyin.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${MY_P}.tar.gz
		http://open-gram.googlecode.com/files/dict.utf8.tar.bz2
		http://open-gram.googlecode.com/files/lm_sc.t3g.arpa.tar.bz2"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-db/sqlite:3"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${MY_P}.tar.gz"
	mv "${DISTDIR}/dict.utf8.tar.bz2" "${S}/raw/" || die "dict file not found"
	mv "${DISTDIR}/lm_sc.t3g.arpa.tar.bz2" "${S}/raw/" || die "dict file not found"
}

src_compile() {
	escons --prefix="/usr"
}

src_install() {
	escons --prefix="/usr" --install-sandbox="${D}" install
}

pkg_postinst() {
	elog ""
	elog "To use any wrapper for ${PN}, please merge any of the following"
	elog "packages: "
	elog "emerge app-i18n/ibus-sunpinyin"
	elog "emerge app-i18n/scim-sunpinyin"
	elog "emerge app-i18n/xsunpinyin"
	elog ""
}
