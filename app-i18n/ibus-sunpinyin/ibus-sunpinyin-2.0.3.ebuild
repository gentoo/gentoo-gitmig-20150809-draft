# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-sunpinyin/ibus-sunpinyin-2.0.3.ebuild,v 1.1 2011/02/20 05:03:36 qiaomuf Exp $

EAPI="1"
PYTHON_DEPEND="2:2.5"
inherit python scons-utils

MY_P=${P/_/-}

DESCRIPTION="The SunPinYin IMEngine for IBus Framework"
HOMEPAGE="http://sunpinyin.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${MY_P}.tar.gz"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-i18n/ibus
		app-i18n/sunpinyin"
DEPEND="${RDEPEND}
		sys-devel/gettext"

S="${WORKDIR}/${MY_P}"

src_compile() {
	escons --prefix="/usr"
}

src_install() {
	escons --prefix="/usr" --install-sandbox="${D}" install
}
