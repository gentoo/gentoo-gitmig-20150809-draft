# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/encfs/encfs-1.3.2.1-r1.ebuild,v 1.1 2008/05/04 00:48:32 dragonheart Exp $

inherit versionator eutils

DESCRIPTION="Encrypted Filesystem module for Linux"
SRC_URI="http://arg0.net/users/vgough/download/${PN}-$(replace_version_separator 3 '-').tgz"
HOMEPAGE="http://arg0.net/encfs"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~sparc ~x86"
SLOT="0"
IUSE="nls"

DEPEND=">=dev-libs/openssl-0.9.7
	>=sys-fs/fuse-2.5
	>=dev-libs/rlog-1.3.6
	nls? ( >=sys-devel/gettext-0.14.1 )"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc-4.3.patch
}

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	einfo "Please see http://arg0.net/wiki/encfs/intro2"
	einfo "if this is your first time using encfs."
}
