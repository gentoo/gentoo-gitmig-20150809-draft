# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/thttpd/thttpd-2.25b-r2.ebuild,v 1.2 2005/03/27 17:27:55 stuart Exp $

PHPSAPI="thttpd"

MY_PHP_P="php-5.0.3"
MY_THTTPD_P="${P%[a-z]*}"

inherit php5-sapi-r2 flag-o-matic

DESCRIPTION="Small and fast multiplexing webserver."
HOMEPAGE="http://www.acme.com/software/thttpd/"
SRC_URI="http://www.acme.com/software/thttpd/${P}.tar.gz
		php? ( http://www.php.net/distributions/${MY_PHP_P}.tar.gz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="static php"

DEPEND="virtual/libc"

PHP_S="${WORKDIR}/${MY_PHP_P}"

pkg_setup() {
	if useq php ; then
		php5-sapi-r2_pkg_setup
	fi
}

src_unpack() {
	unpack ${A}

	if useq php ; then
		cd ${WORKDIR}
		epatch ${FILESDIR}/${MY_THTTPD_P}/php-5.0.3-thttpd-2.25b.patch
		epatch ${FILESDIR}/php-5.0.3-IOV.patch
		php5-sapi-r2_src_unpack
	fi
}

src_compile() {
	# compile PHP5 first
	if useq php ; then
		my_conf="--with-thttpd=${S}"
		php5-sapi-r2_src_compile
		php5-sapi-r2_src_install
	fi

	cd ${S}

	## TODO: what to do with IPv6?

	append-ldflags -Wl,-z,now
	use static && append-ldflags -static

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	if useq php ; then
		# we have to do the install again, because Portage wipes anything
		# put into $D during src_compile
		#
		# ideally, we need to improve the eclass
		php5-sapi-r2_src_install
	fi

	cd ${S}
	dodir /usr/share/man/man1
	make prefix=${D}/usr \
		MANDIR=${D}/usr/share/man \
		WEBGROUP=nogroup \
		WEBDIR=${D}/var/www/localhost \
		"$@" install || die "make install failed"

	mv ${D}/usr/sbin/{,th_}htpasswd
	mv ${D}/usr/share/man/man1/{,th_}htpasswd.1

	newinitd ${FILESDIR}/${MY_THTTPD_P}/thttpd.init thttpd
	newconfd ${FILESDIR}/${MY_THTTPD_P}/thttpd.confd thttpd

	dodoc README INSTALL TODO

	insinto /etc/thttpd
	doins ${FILESDIR}/${MY_THTTPD_P}/thttpd.conf.sample
}

pkg_postinst() {
	if useq php ; then
		php5-sapi-r2_pkg_postinst
	fi

	einfo "Adjust THTTPD_DOCROOT in /etc/conf.d/thttpd !"
}
