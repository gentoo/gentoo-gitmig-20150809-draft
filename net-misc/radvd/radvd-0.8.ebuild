# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/radvd/radvd-0.8.ebuild,v 1.2 2005/08/23 13:14:14 flameeyes Exp $

inherit eutils

DESCRIPTION="Linux IPv6 Router Advertisement Daemon (radvd)"
HOMEPAGE="http://v6web.litech.org/radvd/"
SRC_URI="http://v6web.litech.org/radvd/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86 ~ppc ~sparc"
IUSE=""

DEPEND="virtual/libc
	virtual/linux-sources"

pkg_setup() {
	enewgroup radvd
	enewuser radvd -1 -1 /dev/null radvd

	# Force ownership of radvd user and group. fix #19647
	[ -d "/var/run/radvd" ] && chown radvd:radvd /var/run/radvd
}

src_compile() {
	econf --libexecdir=/usr/lib/radvd \
		--with-pidfile=/var/run/radvd/radvd.pid \
		--sysconfdir=/etc/radvd || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc CHANGES COPYRIGHT INTRO.html README TODO

	insinto /etc/radvd
	doins radvd.conf.example

	exeinto /etc/init.d
	doexe ${FILESDIR}/radvd

	dodir /var/run/radvd
	touch ${D}/var/run/radvd/.keep
	chown -R radvd:radvd ${D}/var/run/radvd
	chmod 755 ${D}/var/run/radvd

}
