# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/asuka/asuka-1.0.6.ebuild,v 1.9 2004/07/24 01:57:23 swegener Exp $

inherit eutils

DESCRIPTION="The QuakeNet IRC Server"
HOMEPAGE="http://dev-com.quakenet.org/"
SRC_URI="http://dev-com.quakenet.org/releases/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 sparc ~ppc"

IUSE="debug"
DEPEND="virtual/libc"

src_compile() {
	local myconf=""

	use debug && myconf="${myconf} --enable-debug"

	econf 	--with-symlink=asuka-ircd \
		--with-dpath=/etc/asuka \
		--with-cpath=/etc/asuka/ircd.conf \
		--with-lpath=/var/log/asuka/asuka.log \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	newbin ircd/ircd asuka-ircd

	newman doc/ircd.8 asuka-ircd.8

	dodir /etc/asuka
	insinto /etc/asuka
	doins doc/ircd.conf.sample

	exeinto /etc/init.d
	newexe ${FILESDIR}/asuka.init.d asuka

	insinto /etc/conf.d
	newins ${FILESDIR}/asuka.conf.d asuka

	dodoc INSTALL* LICENSE README* RELEASE.NOTES TODO*
	dodoc doc/readme.* doc/p10.html doc/features.txt doc/Authors
}

pkg_setup() {
	enewuser asuka
}

pkg_postinst() {
	install -d -m 0700 -o asuka -g root ${ROOT}/var/log/asuka

	einfo
	einfo "A sample config file can be found at /etc/asuka/ircd.conf.sample"
	einfo
}
