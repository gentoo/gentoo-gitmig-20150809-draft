# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/monkeyd/monkeyd-0.9.0-r1.ebuild,v 1.2 2006/04/27 18:49:03 chtekk Exp $

inherit toolchain-funcs depend.php

WEBROOT=/var/www/localhost

MY_P="${PN/d}-${PV}"
DESCRIPTION="fast, efficient, (REALLY) small, and easy to configure web server"
HOMEPAGE="http://monkeyd.sourceforge.net/"
SRC_URI="http://monkeyd.sourceforge.net/versions/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE="php"

DEPEND="virtual/libc
	>=sys-apps/portage-2.0.51"
RDEPEND="virtual/libc
	php? ( virtual/httpd-php )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	use php && require_php_cgi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e '/install -m 755 bin\/banana/d' configure || die "sed banana"
}

src_compile() {
	# monkey has it's own funky script ... cant use econf
	env STRIP=true \
	./configure \
		--prefix=/usr \
		--bindir=/usr/bin \
		--cgibin=${WEBROOT}/cgi-bin \
		--sysconfdir=/etc/${PN} \
		--datadir=${WEBROOT}/htdocs \
		--logdir=/var/log/${PN} \
		--lang=en \
		|| die
	# Don't install the banana script, it is broken as is anyway and the 
	# functionality is provided by the ${FILESDIR}/monkeyd.init.d script.
	sed -i '/install -m 755 bin\/banana/d' Makefile
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	make \
		PREFIX=${D}/usr \
		BINDIR=${D}/usr/bin \
		CGIBIN=${D}${WEBROOT}/cgi-bin \
		SYSCONFDIR=${D}/etc/${PN} \
		DATADIR=${D}${WEBROOT}/htdocs \
		LOGDIR=${D}/var/log/${PN} \
		install \
		|| die
	if use php ; then
		dosed '/^#AddScript application\/x-httpd-php/s:^#::' /etc/monkeyd/monkey.conf
		dosed 's:/home/my_home/php/bin/php:/usr/bin/php-cgi:' /etc/monkeyd/monkey.conf
	fi
	[ -e ${ROOT}/${WEBROOT}/htdocs/index.html ] && mv ${D}${WEBROOT}/htdocs/{index,index-monkey}.html
	dosed "s:/var/log/monkeyd/monkey.pid:/var/run/monkey.pid:" /etc/monkeyd/monkey.conf
	newinitd ${FILESDIR}/monkeyd.init.d monkeyd
	newconfd ${FILESDIR}/monkeyd.conf.d monkeyd
	dodoc MODULES HowItWorks.txt README ChangeLog
}
