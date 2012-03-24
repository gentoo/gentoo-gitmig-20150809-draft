# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/thttpd/thttpd-2.25b-r9.ebuild,v 1.1 2012/03/24 02:59:02 blueness Exp $

EAPI="4"

WANT_AUTOCONF=2.1
inherit eutils flag-o-matic autotools

DESCRIPTION="Small and fast multiplexing webserver."
HOMEPAGE="http://www.acme.com/software/thttpd/"
SRC_URI="http://www.acme.com/software/thttpd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="static"

RDEPEND=""
DEPEND="sys-devel/autoconf:2.1"

THTTPD_USER=thttpd
THTTPD_GROUP=thttpd

src_prepare() {
	epatch "${FILESDIR}"/${P}-additional-input-validation.patch
	epatch "${FILESDIR}"/${P}-fix-buffer-overflow.patch
	epatch "${FILESDIR}"/${P}-fix-insecure-tmp-creation.patch
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
	epatch "${FILESDIR}"/${P}-fix-illegal-path-info.patch
	epatch "${FILESDIR}"/${P}-monolithic-timer.patch
	epatch "${FILESDIR}"/${P}-use-Status-header.patch
	epatch "${FILESDIR}"/${P}-use-X-Forwarded-For-header.patch
	epatch "${FILESDIR}"/${P}-respect-CFLAGS--dont-link-static.patch
	epatch "${FILESDIR}"/${P}-ogg-mime-type.patch
	epatch "${FILESDIR}"/${P}-default-to-octet-stream.patch
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
	tc-export CC
	econf
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

	newinitd "${FILESDIR}"/thttpd.init thttpd
	newconfd "${FILESDIR}"/thttpd.confd thttpd

	dodoc README INSTALL TODO

	insinto /etc/logrotate.d
	newins "${FILESDIR}/thttpd.logrotate" thttpd

	insinto /etc/thttpd
	doins "${FILESDIR}"/thttpd.conf.sample
}

pkg_postinst() {
	elog "Adjust THTTPD_DOCROOT in /etc/conf.d/thttpd !"
}
