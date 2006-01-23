# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/anyterm/anyterm-1.1.8.ebuild,v 1.1 2006/01/23 22:50:57 twp Exp $

inherit apache-module eutils toolchain-funcs webapp

DESCRIPTION="A terminal anywhere"
HOMEPAGE="http://anyterm.org/"
SRC_URI="http://anyterm.org/download/${P}.tbz2"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="pam ssl"
DEPEND="
	dev-libs/boost
	>=dev-libs/rote-0.2.8
	>=sys-devel/gcc-3
	virtual/ssh
	pam? ( net-www/mod_auth_pam )
	"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="50_${PN}"
APACHE2_MOD_DEFINE="ANYTERM"
useq ssl && APACHE2_MOD_DEFINE="${APACHE2_MOD_DEFINE} -D SSL"
useq pam && APACHE2_MOD_DEFINE="${APACHE2_MOD_DEFINE} -D AUTH_PAM"
APACHE2_MOD_FILE="${S}/apachemod/.libs/anyterm.so"
DOCFILES="CHANGELOG README"

need_apache2

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/${APACHE2_MOD_CONF}.conf ${S} || die
	epatch ${FILESDIR}/${P}-apachemod-Makefile.patch
	epatch ${FILESDIR}/${P}-common-extern.patch
	epatch ${FILESDIR}/${P}-browser-gentoo.patch

	# The bundled libpbe causes lots of problems because it links to various
	# assorted packages, without any checks. These packages may or not be
	# installed. Here we disable all packages which are not required.
	epatch ${FILESDIR}/${P}-libpbe-no-pg_config.patch
	for f in Database Recoder jpegsize; do
		rm ${S}/libpbe/src/${f}.{cc,hh}
	done
}

src_compile() {
	( cd apachemod && emake CC=$(tc-getCC) CXX=$(tc-getCXX) ) || die
}

src_install() {
	apache-module_src_install

	webapp_src_preinst
	cp browser/* browser/.htaccess ${D}/${MY_HTDOCSDIR}
	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst

	apache-module_pkg_postinst

	if ! built_with_use 'net-www/apache' ssl || ! use pam; then

		if ! built_with_use 'net-www/apache' ssl; then
			eerror "net-www/apache is missing SSL support."
		fi

		if ! use pam; then
			eerror "PAM support disabled."
		fi

		eerror
		eerror "For security reasons, the default Gentoo anyterm installation"
		eerror "requires SSL and PAM.  You will need to edit anyterm's"
		eerror ".htaccess to suit your configuration."
		eerror
		eerror "For more information see:"
		eerror "\thttp://anyterm.org/security.html"
		eerror

		sleep 5

	else

		eerror
		eerror "The default Gentoo installation of Anyterm uses SSL and PAM for"
		eerror "security.  However, you will have to disable logging yourself,"
		eerror "otherwise anyone who can read your log files (EVERYBODY by"
		eerror "default!) can observe all the characters you send, including"
		eerror "passwords!"
		eerror
		eerror "To do this, add"
		eerror "\tenv=!DONTLOG"
		eerror "to the CustomLog directive in"
		eerror "\t/etc/apache2/modules.d/41_mod_ssl.default-vhost.conf"
		eerror
		eerror "If you are using a custom SSL virtual host configuration"
		eerror "(i.e. you don't use -D SSL_DEFAULT_VHOST) then you will need"
		eerror "to modify CustomLog directives elsewhere."
		eerror
		eerror "For more information see:"
		eerror "\thttp://anyterm.org/security.html"
		eerror

		einfo
		einfo "Anyterm is now installed at:"
		einfo "\thttps://localhost/anyterm/anyterm.html"
		einfo

		sleep 5

	fi
}
