# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mhxd/mhxd-0.4.9.ebuild,v 1.1 2004/06/06 22:10:26 kang Exp $

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DESCRIPTION="This is a Hotline 1.5+ compatible *nix Hotline Server. It supports IRC compatibility. See http://www.hotspringsinc.com/"
SRC_URI="http://projects.acidbeats.de/${P}.tar.gz"
HOMEPAGE="http://hotlinex.sf.net/"

IUSE="ipv6 ssl mysql"

DEPEND="virtual/glibc
	ssl? ( >=dev-libs/openssl-0.9.6d )
	mysql? ( >=dev-db/mysql-3.23.52 )
	>=sys-libs/zlib-1.1.4"

SLOT="0"

src_compile() {
	econf \
	`use_enable ssl idea cipher hope compress` \
	`use_enable ipv6` \
	`use_enable mysql sql` \
	--enable-acctedit --enable-irc || die "bad configure"
	emake || die "compile problem"
	make install || die "compile problem"
}

src_install() {
	cd ${S}
	dodoc AUTHORS INSTALL PROBLEMS README* ChangeLog TODO NEWS run/hxd/hxd.conf

	cpdirs="accounts files newsdir etc exec lib"
	insinto /etc; doins run/hxd/hxd.conf
	dosbin run/hxd/bin/hxd
	dobin run/hxd/bin/acctedit

	dodir /var/hxd
	for d in ${cpdirs} ; do
		insinto /var/hxd
		cp -R run/hxd/${d} ${D}/var/hxd/${d}
	done
	insinto /var/hxd ; doins run/hxd/news
	insinto /var/hxd; doins run/hxd/agreement

	keepdir /var/hxd/files
	keepdir /var/hxd/lib
	exeinto /etc/init.d ; newexe ${FILESDIR}/hxd.rc hxd
}

pkg_preinst() {
	if ! groupmod hxd; then
		groupadd hxd 2> /dev/null || \
		die "Failed to create hxd group"
	fi

	if ! id hxd; then
		useradd -s /dev/null -d /var/hxd -c "hxd added by portage" -g hxd hxd
		assert "Failed to create hxd user"
	fi
}

pkg_postinst() {
	#fowners don't do directories :(
	chown -R hxd:hxd /var/hxd
	einfo
	einfo "Welcome to Horline!"
	einfo "Login as admin and no password to your hotline server, and change the password"
	einfo
}
