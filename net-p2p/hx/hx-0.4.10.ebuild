# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/hx/hx-0.4.10.ebuild,v 1.1 2004/07/28 12:25:11 kang Exp $

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
MY_P=mhxd-${PV}

DESCRIPTION="This is a Hotline 1.5+ compatible *nix Hotline Client in CLI. It supports IRC compatibility. See http://www.hotspringsinc.com/"
SRC_URI="http://projects.acidbeats.de/${MY_P}.tar.bz2"
HOMEPAGE="http://hotlinex.sf.net/"

IUSE="ipv6 ssl"

DEPEND="virtual/libc
	>=sys-libs/libtermcap-compat-1.2.3-r1
	ssl? ( >=dev-libs/openssl-0.9.6d )
	>=sys-libs/zlib-1.1.4"

SLOT="0"

src_compile() {
	cd work/${MY_P}
	econf \
	`use_enable ssl idea` \
	`use_enable ssl cipher` \
	`use_enable ssl hope` \
	`use_enable ssl compress` \
	`use_enable ipv6` \
	--enable-hx || die "bad configure"
	emake || die "compile problem"
	make install || die "compile problem"
}

src_install() {
	cd ${P}/work/${MY_P}
	dodoc AUTHORS INSTALL PROBLEMS README* ChangeLog TODO NEWS run/hx/ghxvars run/hx/ghxvars.jp \
	run/hx/hxrc run/hx/hxvars

	dosbin run/hx/bin/hx
}
