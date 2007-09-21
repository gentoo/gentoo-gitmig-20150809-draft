# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/luks-tools/luks-tools-0.0.12-r1.ebuild,v 1.1 2007/09/21 19:39:26 hanno Exp $

inherit eutils

DESCRIPTION="GUI frontend for dm-crypt/luks."
HOMEPAGE="http://www.flyn.org/projects/luks-tools/"
SRC_URI="http://www.flyn.org/projects/luks-tools/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-fs/cryptsetup
	>=dev-python/pygtk-2.8.0
	>=sys-apps/hal-0.5"

S=${WORKDIR}/${P}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/luks-tools-0.0.12-pam-config.patch"
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS FAQ NEWS README TODO
}
