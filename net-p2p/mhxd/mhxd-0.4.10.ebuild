# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mhxd/mhxd-0.4.10.ebuild,v 1.2 2004/08/02 18:27:52 squinky86 Exp $

inherit eutils

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

DESCRIPTION="This is a Hotline 1.5+ compatible *nix Hotline Server. It supports IRC compatibility. See http://www.hotspringsinc.com/"
SRC_URI="http://projects.acidbeats.de/${P}.tar.bz2"
HOMEPAGE="http://hotlinex.sf.net/"

IUSE="ipv6 ssl mysql"

DEPEND="virtual/libc
	ssl? ( >=dev-libs/openssl-0.9.6d )
	mysql? ( >=dev-db/mysql-3.23.52 )
	>=sys-libs/zlib-1.1.4"

SLOT="0"

src_compile() {
	econf \
	`use_enable ssl idea` \
	`use_enable ssl cipher` \
	`use_enable ssl hope` \
	`use_enable ssl compress` \
	`use_enable ipv6` \
	`use_enable mysql sql` \
	--enable-acctedit || die "bad configure"
	emake || die "compile problem"
	make install || die "compile problem"
}

src_install() {
	cd ${S}
	dodoc hxd.sql AUTHORS INSTALL PROBLEMS README* ChangeLog TODO NEWS run/hxd/hxd.conf

	cpdirs="accounts files newsdir etc exec lib"
	dodir /etc/mhxd
	insinto /etc/mhxd; doins run/hxd/hxd.conf
	dosbin run/hxd/bin/hxd
	dobin run/hxd/bin/acctedit

	dodir /var/mhxd
	for d in ${cpdirs} ; do
		insinto /var/mhxd
		cp -R run/hxd/${d} ${D}/var/mhxd/${d}
	done
	insinto /var/mhxd ; doins run/hxd/news
	insinto /var/mhxd; doins run/hxd/agreement
	insinto /var/mhxd; doins run/hxd/.common

	keepdir /var/mhxd/files
	keepdir /var/mhxd/lib
	exeinto /etc/init.d ; newexe ${FILESDIR}/hxd.rc mhxd
}

pkg_preinst() {
	if ! groupmod hxd; then
		enewgroup hxd -1 || die "Failed to create hxd group"
	fi

	if ! id hxd; then
		enewuser hxd -1 /bin/bash /var/hxd hxd || "Failed to create hxd user"
	fi
}

pkg_postinst() {
	#fowners don't do directories :(
	chown -R hxd:hxd /var/mhxd || "Failed to set owner on /var/mhxd"
	einfo
	einfo "Welcome to Horline!"
	einfo "Do '/etc/init.d/mhxd start' to start the server, then"
	einfo "Login as admin and no password to your hotline server, and change the password"
	einfo
}
