# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wbarconf/wbarconf-0.7.2.ebuild,v 1.1 2008/12/06 13:03:36 ssuominen Exp $

inherit eutils

DESCRIPTION="Configuration GUI for x11-misc/wbar"
HOMEPAGE="http://www.ihku.biz/wbarconf"
SRC_URI="http://www.ihku.biz/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-misc/wbar-1.3.3
	>=dev-python/pygtk-2.10"
DEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-install.patch
}

src_install() {
	./install.sh "${D}/usr"
	prepalldocs
}
