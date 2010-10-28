# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vtun/vtun-2.6-r1.ebuild,v 1.8 2010/10/28 09:40:53 ssuominen Exp $

inherit eutils

IUSE="ssl"

S=${WORKDIR}/vtun
DESCRIPTION="Create virtual tunnels over TCP/IP networks with traffic shaping, encryption, and compression"
SRC_URI="mirror://sourceforge/vtun/${P}.tar.gz"
HOMEPAGE="http://vtun.sourceforge.net/"
KEYWORDS="alpha ~amd64 ~ppc sparc x86"
LICENSE="GPL-2"
SLOT="0"

# NOTE: you also need the tun/tap driver compiled into your kernel
#		to do tun/tap tunneling
DEPEND=">=sys-libs/zlib-1.1.3
	>=dev-libs/lzo-2
	sys-devel/bison
	ssl? ( >=dev-libs/openssl-0.9.6c )"

RDEPEND=">=sys-libs/zlib-1.1.3
	ssl? ( >=dev-libs/openssl-0.9.6c )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-makefile.patch
	epatch "${FILESDIR}"/${P}-lzo2.patch
}

src_compile() {
	local use_opts
	use_opts=""
	if ! use ssl
	then
		use_opts="--disable-ssl"
	fi

	econf ${use_opts} --with-ssl-headers=/usr/include/openssl || die

	make || die
}

src_install () {
	make DESTDIR="${D}" prefix=/usr \
		mandir=/usr/share/man \
		infodir=/usr/share/info \
		datadir=/usr/share \
		sysconfdir=/etc \
		localstatedir=/var/lib \
		install || die

	dodoc ChangeLog Credits FAQ README README.Setup README.Shaper TODO

	newinitd "${FILESDIR}"/vtun.rc vtun

	insinto etc
	doins "${FILESDIR}"/vtund-start.conf
}

pkg_postinst () {
	einfo ">>> You will need the Universal TUN/TAP driver compiled into"
	einfo ">>> your kernel or as a module to use the associated tunnel"
	einfo ">>> modes in vtun. 2.2 users will need to download and install"
	einfo ">>> the driver from http://vtun.sourceforge.net/tun"
}
