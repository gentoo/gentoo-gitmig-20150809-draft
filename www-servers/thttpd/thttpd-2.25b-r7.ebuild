# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/thttpd/thttpd-2.25b-r7.ebuild,v 1.4 2007/08/13 22:04:48 dertobi123 Exp $

inherit eutils flag-o-matic

MY_P="${P%[a-z]*}"

DESCRIPTION="Small and fast multiplexing webserver."
HOMEPAGE="http://www.acme.com/software/thttpd/"
SRC_URI="http://www.acme.com/software/thttpd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~hppa ~mips ppc ~sparc x86 ~x86-fbsd"
IUSE="static"

THTTPD_USER=thttpd
THTTPD_GROUP=thttpd

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${MY_P}/*.diff
}

pkg_setup() {
	enewgroup ${THTTPD_GROUP}
	enewuser ${THTTPD_USER}  -1 -1 -1 ${THTTPD_GROUP}
}

src_compile() {
	## TODO: what to do with IPv6?

	append-ldflags $(bindnow-flags)
	use static && append-ldflags -static

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	dodir /usr/share/man/man1
	make prefix=${D}/usr \
		MANDIR=${D}/usr/share/man \
		WEBGROUP=${THTTPD_GROUP} \
		WEBDIR=${D}/var/www/localhost \
		"$@" install || die "make install failed"

	mv ${D}/usr/sbin/{,th_}htpasswd
	mv ${D}/usr/share/man/man1/{,th_}htpasswd.1

	newinitd ${FILESDIR}/${MY_P}/thttpd.init thttpd
	newconfd ${FILESDIR}/${MY_P}/thttpd.confd thttpd

	dodoc README INSTALL TODO

	insinto /etc/logrotate.d
	newins "${FILESDIR}/thttpd.logrotate" thttpd

	insinto /etc/thttpd
	doins ${FILESDIR}/${MY_P}/thttpd.conf.sample
}

pkg_postinst() {
	elog "Adjust THTTPD_DOCROOT in /etc/conf.d/thttpd !"
}
