# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/easy-slow-down-manager/easy-slow-down-manager-0.3.ebuild,v 1.1 2011/06/22 08:55:10 angelos Exp $

EAPI=4
inherit linux-mod

DESCRIPTION="provides Linux users with functionality similar to Samsung Easy Speed Up Manager"
HOMEPAGE="http://code.google.com/p/easy-slow-down-manager/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}

BUILD_TARGETS="all"
MODULE_NAMES="samsung-backlight() easy_slow_down_manager()"

src_compile() {
	BUILD_PARAMS="KVERSION=${KV_FULL}"
	linux-mod_src_compile
}
