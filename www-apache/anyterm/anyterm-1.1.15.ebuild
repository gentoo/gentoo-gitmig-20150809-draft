# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/anyterm/anyterm-1.1.15.ebuild,v 1.1 2007/09/08 16:30:43 hollow Exp $

inherit apache-module eutils toolchain-funcs webapp

KEYWORDS="~x86"

DESCRIPTION="A terminal anywhere."
HOMEPAGE="http://anyterm.org/"
SRC_URI="http://anyterm.org/download/${P}.tbz2"
LICENSE="GPL-2"
SLOT="0"
IUSE="opera pam ssl"

DEPEND="dev-libs/boost
		>=dev-libs/rote-0.2.8
		>=sys-devel/gcc-3
		virtual/ssh
		pam? ( www-apache/mod_auth_pam )"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="50_${PN}"
APACHE2_MOD_DEFINE="ANYTERM"
use pam && APACHE2_MOD_DEFINE="${APACHE2_MOD_DEFINE} -D AUTH_PAM"
use ssl && APACHE2_MOD_DEFINE="${APACHE2_MOD_DEFINE} -D SSL"
APACHE2_MOD_FILE="${S}/apachemod/.libs/${PN}.so"
DOCFILES="CHANGELOG README"

WEBAPP_MANUAL_SLOT="yes"

need_apache2

pkg_setup() {
	webapp_pkg_setup

	apache-module_pkg_setup

	if use ssl && ! built_with_use www-servers/apache ssl; then
		eerror "Build www-servers/apache with USE=ssl." && die
		die
	fi

	if ! built_with_use dev-libs/boost threads; then
		eerror "Build dev-libs/boost with USE=threads."
		die
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-browser-gentoo.patch"
	sed -i -e "s:apr-config:$(apr_config):g" apachemod/Makefile
}

src_compile() {
	( cd apachemod && emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" || die "Apachemod make failed" )

	# Modify browser files to reflect USE flags.
	for flag in opera pam ssl ; do
		if use ${flag} ; then
			sed -i -e "s/^#USE=${flag}#//" browser/{*,.htaccess}
			sed -i -e "/^#USE=-${flag}#/D" browser/{*,.htaccess}
		else
			sed -i -e "s/^#USE=-${flag}#//" browser/{*,.htaccess}
			sed -i -e "/^#USE=${flag}#/D" browser/{*,.htaccess}
		fi
	done
}

src_install() {
	apache-module_src_install

	webapp_src_preinst
	cp -f browser/{*,.htaccess} "${D}/${MY_HTDOCSDIR}"
	webapp_postinst_txt en "${FILESDIR}/${P}-postinst-en.txt"
	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst

	apache-module_pkg_postinst

	if ! use ssl ; then
		ewarn "USE=-ssl:   Anyterm without SSL is very insecure!"
	fi
	if ! use pam ; then
		ewarn "USE=-pam:   You will have to add your own authentication"
		ewarn "            mechanism."
	fi
	if use opera ; then
		ewarn "USE=opera:  Be sure to disable some logging in your Apache"
		ewarn "            configuration files!"
	fi
	if ! use ssl || ! use pam || use opera ; then
		ewarn "For more information see http://anyterm.org/security.html"
	fi
}
