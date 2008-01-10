# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/anyterm/anyterm-1.1.16.ebuild,v 1.1 2008/01/10 16:16:00 hollow Exp $

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

need_apache2_2

pkg_setup() {
	webapp_pkg_setup
	apache-module_pkg_setup

	if use ssl && ! built_with_use www-servers/apache ssl; then
		die "Build www-servers/apache with USE=ssl."
	fi

	if ! built_with_use --missing true dev-libs/boost threads; then
		die "Build dev-libs/boost with USE=threads."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-1.1.15-browser-gentoo.patch
	sed -i -e "s:apr-config:apr-1-config:g" apachemod/Makefile
}

src_compile() {
	cd apachemod
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" || die "Apachemod make failed"
	cd ..

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
	webapp_postinst_txt en "${FILESDIR}"/${PN}-1.1.15-postinst-en.txt
	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst
	apache-module_pkg_postinst

	use ssl || ewarn "USE=-ssl: Anyterm without SSL is very insecure!"
	use pam || ewarn "USE=-pam: You will have to add your own authentication mechanism."
	use opera || ewarn "USE=opera: Be sure to disable some logging in your Apache configuration files!"
	if ! use ssl || ! use pam || use opera ; then
		ewarn "For more information see http://anyterm.org/security.html"
	fi
}
