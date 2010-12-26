# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/luks-tools/luks-tools-0.0.14.ebuild,v 1.2 2010/12/26 05:33:28 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="GUI frontend for dm-crypt/luks."
HOMEPAGE="http://www.flyn.org/projects/luks-tools/"
SRC_URI="http://www.flyn.org/projects/luks-tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-fs/cryptsetup-1.0.5
	>=dev-python/pygtk-2.8.0
	>=sys-apps/hal-0.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.0.12-pam-config.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog FAQ NEWS README TODO
}
