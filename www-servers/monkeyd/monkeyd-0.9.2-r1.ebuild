# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/monkeyd/monkeyd-0.9.2-r1.ebuild,v 1.1 2009/04/19 18:51:36 bangert Exp $

EAPI="2"

inherit toolchain-funcs eutils

WEBROOT=/var/www/localhost

MY_P="${PN/d}-${PV}"
DESCRIPTION="Fast, efficient, (REALLY) small, and easy to configure web server"
HOMEPAGE="http://monkeyd.sourceforge.net/"
SRC_URI="http://monkeyd.sourceforge.net/versions/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"
IUSE="php"

RDEPEND="php? ( virtual/httpd-php[cgi] )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/monkeyd-0.9.2-honor-LDFLAGS-and-support--as-needed-and-fix-jobserver.patch"

	# Don't install the banana script, it is broken as is anyway and the
	# functionality is provided by the ${FILESDIR}/monkeyd.init.d script.
	sed -i '/install -m 755 bin\/banana/d' configure || die "sed banana"
}

src_configure() {
	# monkey has it's own funky script ... cant use econf
	./configure \
		--prefix=/usr \
		--bindir=/usr/bin \
		--cgibin=${WEBROOT}/cgi-bin \
		--sysconfdir=/etc/${PN} \
		--datadir=${WEBROOT}/htdocs \
		--logdir=/var/log/${PN} \
		--lang=en \
		|| die
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make \
		PREFIX="${D}"/usr \
		BINDIR="${D}"/usr/bin \
		CGIBIN="${D}"${WEBROOT}/cgi-bin \
		SYSCONFDIR="${D}"/etc/${PN} \
		DATADIR="${D}"${WEBROOT}/htdocs \
		LOGDIR="${D}"/var/log/${PN} \
		install \
		|| die "make install failed"

	if use php ; then
		dosed '/^#AddScript application\/x-httpd-php/s:^#::' /etc/monkeyd/monkey.conf
		dosed 's:/home/my_home/php/bin/php:/usr/bin/php-cgi:' /etc/monkeyd/monkey.conf
	fi

	mv "${D}"${WEBROOT}/htdocs/{index,index-monkey}.html

	dosed "s:/var/log/monkeyd/monkey.pid:/var/run/monkey.pid:" /etc/monkeyd/monkey.conf
	newinitd "${FILESDIR}"/monkeyd.init.d monkeyd
	newconfd "${FILESDIR}"/monkeyd.conf.d monkeyd
	dodoc README MODULES *.txt
}
