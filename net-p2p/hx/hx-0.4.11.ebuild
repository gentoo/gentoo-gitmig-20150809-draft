# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/hx/hx-0.4.11.ebuild,v 1.1 2006/09/20 15:55:18 kang Exp $

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
MY_P=mhxd-${PV}

DESCRIPTION="This is a Hotline 1.5+ compatible *nix Hotline Client in CLI. It supports IRC compatibility. See http://www.hotspringsinc.com/"
SRC_URI="http://projects.acidbeats.de/${MY_P}.tar.bz2"
HOMEPAGE="http://hotlinex.sf.net/"

IUSE="ssl"

DEPEND="virtual/libc
	ssl? ( >=dev-libs/openssl-0.9.6d )
	>=sys-libs/zlib-1.1.4"

SLOT="0"

src_compile() {
	cd work/${MY_P}
	libtoolize --copy --force
	econf \
	`use_enable ssl idea` \
	`use_enable ssl cipher` \
	`use_enable ssl hope` \
	`use_enable ssl compress` \
	--enable-hx || die "bad configure"
	emake || die "compile problem"
	make install || die "compile problem"
}

src_install() {
	cd ${PF}/work/${MY_P}
	dodoc AUTHORS INSTALL PROBLEMS README* ChangeLog TODO NEWS run/hx/ghxvars run/hx/ghxvars.jp \
	run/hx/hxrc run/hx/hxvars

	dobin run/hx/bin/hx
}
