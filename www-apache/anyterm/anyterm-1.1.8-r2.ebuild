# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/anyterm/anyterm-1.1.8-r2.ebuild,v 1.2 2007/01/15 15:13:34 chtekk Exp $

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
		pam? ( net-www/mod_auth_pam )"
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

	use ssl && ! built_with_use net-www/apache ssl && \
		eerror "Build net-www/apache with USE=ssl."
	use pam && ! built_with_use net-www/mod_auth_pam apache2 && \
		eerror "Build net-www/mod_auth_pam with USE=apache2."
}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-apachemod-Makefile.patch"
	epatch "${FILESDIR}/${P}-common-extern.patch"
	epatch "${FILESDIR}/${P}-browser-gentoo.patch"

	# The bundled libpbe causes lots of problems because it links to various
	# assorted packages, without any checks. These packages may or not be
	# installed. Here we disable all packages which are not required.
	epatch "${FILESDIR}/${P}-libpbe-no-pg_config.patch"
	for f in Database Recoder jpegsize ; do
		rm -f "${S}"/libpbe/src/${f}.{cc,hh}
	done
}

src_compile() {
	( cd apachemod && emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" ) || die "Apachemod make failed"

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
