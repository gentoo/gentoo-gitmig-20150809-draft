# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/thttpd/thttpd-2.25b-r8.ebuild,v 1.2 2011/08/03 20:34:00 zmedico Exp $

EAPI="3"

WANT_AUTOCONF=2.1
inherit eutils flag-o-matic autotools

MY_P="${P%[a-z]*}"

DESCRIPTION="Small and fast multiplexing webserver."
HOMEPAGE="http://www.acme.com/software/thttpd/"
SRC_URI="http://www.acme.com/software/thttpd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="static"

THTTPD_USER=thttpd
THTTPD_GROUP=thttpd

src_prepare() {
	epatch "${FILESDIR}"/${MY_P}/*.diff
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
	epatch "${FILESDIR}"/${P}-fix-illegal-path-info.patch
	epatch "${FILESDIR}"/${P}-monolithic-timer.patch
	epatch "${FILESDIR}"/${P}-use-Status-header.patch
	epatch "${FILESDIR}"/${P}-use-X-Forwarded-For-header.patch
	epatch "${FILESDIR}"/${P}-respect-CFLAGS--dont-link-static.patch
	eautoreconf
}

pkg_setup() {
	ebegin "Creating thttpd user and group"
	enewgroup ${THTTPD_GROUP}
	enewuser ${THTTPD_USER} -1 -1 -1 ${THTTPD_GROUP}
	eend ${?}
}

src_configure() {
	use static && append-ldflags -static
	econf || die "econf failed"
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install () {
	dodir /usr/share/man/man1
	make prefix="${ED}"/usr \
		MANDIR="${ED}"/usr/share/man \
		WEBGROUP=${THTTPD_GROUP} \
		WEBDIR="${ED}"/var/www/localhost \
		"$@" install || die "make install failed"

	mv "${ED}"/usr/sbin/{,th_}htpasswd
	mv "${ED}"/usr/share/man/man1/{,th_}htpasswd.1

	newinitd "${FILESDIR}"/${MY_P}/thttpd.init thttpd
	newconfd "${FILESDIR}"/${MY_P}/thttpd.confd thttpd

	dodoc README INSTALL TODO

	insinto /etc/logrotate.d
	newins "${FILESDIR}/thttpd.logrotate" thttpd

	insinto /etc/thttpd
	doins "${FILESDIR}"/${MY_P}/thttpd.conf.sample
}

pkg_postinst() {
	elog "Adjust THTTPD_DOCROOT in /etc/conf.d/thttpd !"
}
