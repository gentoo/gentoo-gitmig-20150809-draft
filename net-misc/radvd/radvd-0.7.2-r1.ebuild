# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/radvd/radvd-0.7.2-r1.ebuild,v 1.1 2003/04/21 15:11:30 gmsoft Exp $

DESCRIPTION="Linux IPv6 Router Advertisement Daemon (radvd)"
HOMEPAGE="http://v6web.litech.org/radvd/"
SRC_URI="http://v6web.litech.org/radvd/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 hppa"

DEPEND="virtual/glibc
	virtual/kernel"

pkg_preinst() {
	# Force ownership of radvd user and group. fix #19647
	[ -d "/var/run/radvd" ] && chown 75.75 /var/run/radvd
	
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
	touch ${D}/var/run/radvd/.keep
	chown -R 75.75 ${D}/var/run/radvd
	chmod 755 ${D}/var/run/radvd
			
}
