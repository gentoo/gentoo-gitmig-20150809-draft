# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vtun/vtun-2.5.ebuild,v 1.12 2004/01/22 23:39:00 zul Exp $

IUSE="ssl"

S=${WORKDIR}/vtun
DESCRIPTION="Create virtual tunnels over TCP/IP networks with traffic shaping, encryption, and compression"
SRC_URI="mirror://sourceforge/vtun/${P}.tar.gz"
HOMEPAGE="http://vtun.sourceforge.net/"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"
SLOT="0"

# NOTE: you also need the tun/tap driver compiled into your kernel
#		to do tun/tap tunneling
DEPEND="virtual/glibc
	>=sys-libs/zlib-1.1.3
	>=dev-libs/lzo-1.07
	sys-devel/bison
	ssl? ( >=dev-libs/openssl-0.9.6c )"

src_unpack() {
	unpack ${A} && cd ${S} || die
	patch -p1 < ${FILESDIR}/${PN}-${PV}-expect.patch || die
	patch -p1 < ${FILESDIR}/${PN}-${PV}-makefile.patch || die
}

src_compile() {
	local use_opts
	use_opts=""
	if [ -z "`use ssl`" ]
	then
		use_opts="--disable-ssl"
	fi

	econf ${use_opts} --with-ssl-headers=/usr/include/openssl || die

	make || die
}

src_install () {
	make DESTDIR=${D} prefix=/usr \
		mandir=/usr/share/man \
		infodir=/usr/share/info \
		datadir=/usr/share \
		sysconfdir=/etc \
		localstatedir=/var/lib \
		install || die

	dodoc ChangeLog Credits FAQ README README.Setup README.Shaper TODO

	exeinto etc/init.d;
	newexe ${FILESDIR}/vtun.rc vtun

	insinto etc
	doins ${FILESDIR}/vtund-start.conf
}

pkg_postinst () {
	echo ">>> You will need the Universal TUN/TAP driver compiled into"
	echo ">>> your kernel or as a module to use the associated tunnel"
	echo ">>> modes in vtun. 2.2 users will need to download and install"
	echo ">>> the driver from http://vtun.sourceforge.net/tun"
}
