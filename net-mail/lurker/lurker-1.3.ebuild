# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit eutils webapp

DESCRIPTION="An e-mail list archive utility with an extensive web interface and multi-language support"
SRC_URI="mirror://sourceforge/lurker/${P}.tar.gz mirror://sourceforge/lurker/mimelib-3.1.1.tar.gz"
HOMEPAGE="http://lurker.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-devel/gcc-2.95
	dev-libs/libxslt
	sys-libs/zlib
	net-www/apache"

INSTALLDIR="/usr/local/lurker"

pkg_setup() {
		webapp_pkg_setup
}

src_unpack() {
	unpack lurker-${PV}.tar.gz && cd "${S}"
	unpack mimelib-3.1.1.tar.gz
}

src_compile() {
	econf \
	    --prefix=${INSTALLDIR} \
	    --with-mimelib-local \
	|| die "configure failed"

	emake || die "make failed"
}

src_install () {

	webapp_src_preinst

	dodoc ChangeLog FAQ INSTALL NEWS README AUTHORS COPYING
	rm -f ChangeLog FAQ NEWS README AUTHORS COPYING
	make install DESTDIR=${D} || die

	# Put files into webapp-config dirs

	mv ${D}/usr/local/lurker/lib/cgi-bin/*.cgi ${D}${MY_CGIBINDIR} || die
	rm -rf ${D}/usr/local/lurker/lib/cgi-bin || die

	mv ${D}/var/lib/www/lurker/* ${D}${MY_HTDOCSDIR} || die
	rm -rf ${D}/var/lib/www/lurker || die

	mv ${S}/lurker.conf ${D}${MY_HOSTROOTDIR} || die
	rm -f ${S}/lurker.conf || die

	csplit -s INSTALL %/usr/local/etc/lurker.conf% || die
	mv xx00 INSTALL || die
	/bin/sed -i -e "s#/usr/local/etc/lurker.conf#/var/www/<hostname>/lurker.conf#" \
				-e "s#/lurker/lurker.conf#/lurker.conf#" \
		${S}/INSTALL

	# Extract out the recommended .htaccess file and install it into
	# the htdocs directory
	csplit -s INSTALL %avoids\ 404%+2	|| die
	echo "        Options FollowSymLinks" > htaccess || die
	cat xx00 >> htaccess || die
	csplit -s htaccess /^8\ point/-1 || die
	mv xx00 ${D}${MY_HTDOCSDIR}/.htaccess || die
	rm -f xx*

	mkdir ${D}/usr/bin
	mv ${D}/usr/local/lurker/bin/* ${D}/usr/bin || die
	rm -rf ${D}/usr/local

	rm -rf ${D}/var/lib

	# Declare all the server owned directories
	webapp_serverowned ${MY_CGIBINDIR}
	webapp_serverowned ${MY_HTDOCSDIR}
	webapp_serverowned ${MY_HTDOCSDIR}/attach
	webapp_serverowned ${MY_HTDOCSDIR}/fmt
	webapp_serverowned ${MY_HTDOCSDIR}/imgs
	webapp_serverowned ${MY_HTDOCSDIR}/list
	webapp_serverowned ${MY_HTDOCSDIR}/mbox
	webapp_serverowned ${MY_HTDOCSDIR}/message
	webapp_serverowned ${MY_HTDOCSDIR}/mindex
	webapp_serverowned ${MY_HTDOCSDIR}/search
	webapp_serverowned ${MY_HTDOCSDIR}/splash
	webapp_serverowned ${MY_HTDOCSDIR}/thread
	# Make sure all the empty directories are kept.
	keepdir ${MY_HTDOCSDIR}/attach
	keepdir ${MY_HTDOCSDIR}/list
	keepdir ${MY_HTDOCSDIR}/mbox
	keepdir ${MY_HTDOCSDIR}/message
	keepdir ${MY_HTDOCSDIR}/mindex
	keepdir ${MY_HTDOCSDIR}/search
	keepdir ${MY_HTDOCSDIR}/splash
	keepdir ${MY_HTDOCSDIR}/thread

	# Declare config files so they are not hardlinked
	webapp_configfile ${MY_HOSTROOTDIR}/lurker.conf
	webapp_configfile ${MY_HTDOCSDIR}/.htaccess
	webapp_postinst_txt en INSTALL
	webapp_src_install
}

pkg_postinst() {
	ewarn "The lurker.conf file will be installed into your "
	ewarn "document root directory for the virtual host."
	ewarn "use the command"
	ewarn "     webapp-config"
	ewarn "to install lurker for each virtual host and then edit"
	ewarn "the lurker.conf file for that host."
	ewarn
	ewarn "If you installed lurker into any directory other than /"
	ewarn "you must also edit the .htaccess file installed into the"
	ewarn "lurker directory"
	einfo
	einfo "The following is an example virtual host definition "
	einfo
	einfo "<VirtualHost *>"
	einfo "	ServerAdmin webmaster@domain.com"
	einfo "	ServerName  server.domain.com"
	einfo "	DocumentRoot /var/www/<hostname>/htdocs"
	einfo "		<Directory \"/var/www/lists.worcesterapa.org/htdocs\"> "
	einfo "			AllowOverride All"
	einfo "			Order allow,deny"
	einfo "			Allow from all"
	einfo "		</Directory>"
	einfo
	einfo "	ScriptAlias /cgi-bin/ \"/var/www/<hostname>/cgi-bin/\""
	einfo
	einfo "		<Directory \"/var/www/<hostname>/cgi-bin\">"
	einfo "			Options None"
	einfo "			AllowOverride None"
	einfo "			Order allow,deny"
	einfo "			Allow from all"
	einfo "		</Directory>"
	einfo "</Virtualhost>"
	einfo
}
