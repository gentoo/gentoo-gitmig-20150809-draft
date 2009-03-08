# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/luks-tools/luks-tools-0.0.12-r1.ebuild,v 1.4 2009/03/08 22:11:45 hanno Exp $

inherit eutils autotools

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

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-pam-config.patch" || die "epatch failed"
	epatch "${FILESDIR}/${P}-disable-werror.patch" || die "epatch failed"
	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS FAQ NEWS README TODO
}
