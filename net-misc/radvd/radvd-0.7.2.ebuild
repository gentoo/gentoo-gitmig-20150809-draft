# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/radvd/radvd-0.7.2.ebuild,v 1.5 2003/09/05 22:01:49 msterret Exp $

DESCRIPTION="Linux IPv6 Router Advertisement Daemon (radvd)"
HOMEPAGE="http://v6web.litech.org/radvd/"
SRC_URI="http://v6web.litech.org/radvd/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	virtual/kernel"

pkg_preinst() {
	if ! groupmod radvd; then
		groupadd -g 75 radvd || die "problem adding group radvd"
	fi

	usermod radvd &>/dev/null
	if [ $? != 2 ]; then
		useradd -u 75 -g radvd -s /bin/false -d / -c "Router Advertisement Daemon (radvd)" radvd
		assert "problem adding user radvd"
	fi
}

src_compile() {
	econf --libexecdir=/usr/lib/radvd \
		--with-pidfile=/var/run/radvd/radvd.pid \
		--sysconfdir=/etc/radvd
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
	fowners radvd.radvd /var/run/radvd
	fperms 755 /var/run/radvd
}

pkg_postinst() {
	einfo To make it work you have to configure /etc/radvd/radvd.conf and put
	einfo the line net.ipv6.conf.all.forwarding = 1 in sysctl.conf or just run
	einfo sysctl -w net.ipv6.conf.all.forwarding=1 in your firewallscripts before
	einfo starting radvd.
	einfo
	einfo echo 1 \> /proc/sys/net/ipv6/conf/all/forwarding should also work.
	einfo
	einfo "rc-update add radvd default" should make it start at boottime.
}
