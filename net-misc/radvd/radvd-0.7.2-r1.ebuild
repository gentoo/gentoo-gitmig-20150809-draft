# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/radvd/radvd-0.7.2-r1.ebuild,v 1.8 2004/11/03 00:21:33 vapier Exp $

DESCRIPTION="Linux IPv6 Router Advertisement Daemon (radvd)"
HOMEPAGE="http://v6web.litech.org/radvd/"
SRC_URI="http://v6web.litech.org/radvd/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 arm hppa x86"
IUSE=""

DEPEND="virtual/libc
	virtual/kernel"

pkg_preinst() {
	# Force ownership of radvd user and group. fix #19647
	[ -d "/var/run/radvd" ] && chown 75:75 /var/run/radvd

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
	chown -R 75:75 ${D}/var/run/radvd
	chmod 755 ${D}/var/run/radvd

}
