# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/thttpd/thttpd-2.25b.ebuild,v 1.1 2005/02/09 16:12:53 ka0ttic Exp $

inherit flag-o-matic

MY_P="${P%[a-z]*}"

DESCRIPTION="Small and fast multiplexing webserver."
HOMEPAGE="http://www.acme.com/software/thttpd/"
SRC_URI="http://www.acme.com/software/thttpd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	append-ldflags -Wl,-z,now

	## TODO: what to do with IPv6?
	econf || die
#	if use ipv6; then
#		:
#	fi
	emake || die
}

src_install () {
	dodir /usr/share/man/man1
	make prefix=${D}/usr \
		MANDIR=${D}/usr/share/man \
		WEBGROUP=nogroup \
		WEBDIR=${D}/var/www/localhost \
		"$@" install || die "installation failed :("

	mv ${D}/usr/sbin/{,th_}htpasswd
	mv ${D}/usr/share/man/man1/{,th_}htpasswd.1

	newinitd ${FILESDIR}/${MY_P}/thttpd.init thttpd
	newconfd ${FILESDIR}/${MY_P}/thttpd.confd thttpd

	dodoc README INSTALL TODO

	insinto /etc/thttpd
	doins ${FILESDIR}/${MY_P}/thttpd.conf.sample
}

pkg_postinst() {
	einfo "Adjust THTTPD_DOCROOT in /etc/conf.d/thttpd !"
}
