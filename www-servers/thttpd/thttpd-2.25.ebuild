# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/thttpd/thttpd-2.25.ebuild,v 1.1 2004/08/08 18:34:03 stuart Exp $

MY_P="${P}b"

DESCRIPTION="Small and fast multiplexing webserver."
HOMEPAGE="http://www.acme.com/software/thttpd/"
SRC_URI="http://www.acme.com/software/thttpd/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/libc"
S="${WORKDIR}/${MY_P}"

src_compile() {
	## TODO: what to do with IPv6?
	econf || die
#	if use ipv6; then
#		:
#	fi
	emake || die
}

src_install () {
	mkdir -p ${D}/usr/share/man/man1
	make prefix=${D}/usr \
		MANDIR=${D}/usr/share/man \
		WEBGROUP=nogroup \
		WEBDIR=${D}/var/www/localhost \
		"$@" install || die "installation failed :("

	mv ${D}/usr/sbin/{,th_}htpasswd
	mv ${D}/usr/share/man/man1/{,th_}htpasswd.1


	exeinto /etc/init.d
	newexe ${FILESDIR}/${P}/thttpd.init thttpd
	insinto /etc/conf.d
	newins ${FILESDIR}/${P}/thttpd.confd thttpd
	dodoc README

	insinto /etc/thttpd
	doins ${FILESDIR}/${P}/thttpd.conf.sample
}

pkg_postinst() {
	einfo "Adjust THTTPD_DOCROOT in /etc/conf.d/thttpd !"
}
