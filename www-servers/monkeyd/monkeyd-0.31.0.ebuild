# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/monkeyd/monkeyd-0.31.0.ebuild,v 1.4 2012/03/18 18:00:00 armin76 Exp $

EAPI="4"

inherit toolchain-funcs depend.php multilib

WEBROOT=/var/www/localhost

MY_P="${PN/d}-${PV}"
DESCRIPTION="A small, fast, and scalable web server"
HOMEPAGE="http://www.monkey-project.com/"
SRC_URI="http://monkey-project.com/releases/${PV:0:4}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ppc x86"
IUSE="php"

RDEPEND="php? ( virtual/httpd-php )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	use php && require_php_cgi
}

src_prepare() {
	# Don't install the banana script, it is broken as is anyway and the
	# functionality is provided by the ${FILESDIR}/monkeyd.init.d script.
	sed -i '/install -m 755 bin\/banana/d' configure || die "sed banana"

	# Don't explicitly strip files
	sed -i -e '/$STRIP /d' -e 's/install -s -m 644/install -m 755/' configure || die
}

src_configure() {
	# Non-autotools configure
	./configure \
		--prefix=/usr \
		--bindir=/usr/bin \
		--datadir=${WEBROOT}/htdocs \
		--logdir=/var/log/${PN} \
		--mandir=/usr/share/man \
		--plugdir=/usr/$(get_libdir)/monkeyd/plugins \
		--sysconfdir=/etc/${PN} \
		|| die
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install() {
	default

	if use php ; then
		sed -i -e '/^#AddScript application\/x-httpd-php/s:^#::' "${D}"/etc/monkeyd/monkey.conf || die
		sed -i -e 's:/home/my_home/php/bin/php:/usr/bin/php-cgi:' "${D}"/etc/monkeyd/monkey.conf || die
	fi

	mv "${D}"${WEBROOT}/htdocs/{index,index-monkey}.html

	sed -i -e "s:/var/log/monkeyd/monkey.pid:/var/run/monkey.pid:" "${D}"/etc/monkeyd/monkey.conf || die
	newinitd "${FILESDIR}"/monkeyd.init.d monkeyd
	newconfd "${FILESDIR}"/monkeyd.conf.d monkeyd
}
