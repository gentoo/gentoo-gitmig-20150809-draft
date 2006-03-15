# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/lurker/lurker-2.1.ebuild,v 1.1 2006/03/15 12:18:45 strerror Exp $

inherit eutils webapp

DESCRIPTION="An e-mail list archive utility with an extensive web interface and multi-language support"
SRC_URI="mirror://sourceforge/lurker/${P}.tar.gz mirror://sourceforge/lurker/mimelib-3.1.1.tar.gz"
HOMEPAGE="http://lurker.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=sys-devel/gcc-2.95
	dev-libs/libxslt
	sys-libs/zlib
	net-www/apache"


pkg_setup() {
		webapp_pkg_setup
}

src_unpack() {
	unpack lurker-${PV}.tar.gz && cd "${S}"
	unpack mimelib-3.1.1.tar.gz
}

src_compile() {
	INSTALLDIR="/usr/local/lurker"
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
	make install-config DESTDIR=${D} || die


	# Put files into webapp-config dirs
	mv ${D}/usr/local/lurker/lib/cgi-bin/*.cgi ${D}${MY_CGIBINDIR} || die
	rm -rf ${D}/usr/local/lurker/lib/cgi-bin || die

	mv ${D}/var/lib/www/lurker/* ${D}${MY_HTDOCSDIR} || die
	rm -rf ${D}/var/lib/www/lurker || die

	mv ${S}/lurker.conf ${D}${MY_HOSTROOTDIR} || die
	rm -f ${S}/lurker.conf || die

	mkdir ${D}/usr/bin
	mv ${D}/usr/local/lurker/bin/* ${D}/usr/bin || die
	rm -rf ${D}/usr/local

	rm -rf ${D}/var/lib
	rm -rf ${D}/etc/lurker/lurker.conf

	# Declare all the server owned directories
	webapp_serverowned ${MY_CGIBINDIR}
	webapp_serverowned ${MY_HTDOCSDIR}
	webapp_serverowned ${MY_HTDOCSDIR}/attach
	webapp_serverowned ${MY_HTDOCSDIR}/imgs
	webapp_serverowned ${MY_HTDOCSDIR}/list
	webapp_serverowned ${MY_HTDOCSDIR}/mbox
	webapp_serverowned ${MY_HTDOCSDIR}/message
	webapp_serverowned ${MY_HTDOCSDIR}/mindex
	webapp_serverowned ${MY_HTDOCSDIR}/search
	webapp_serverowned ${MY_HTDOCSDIR}/splash
	webapp_serverowned ${MY_HTDOCSDIR}/thread
	webapp_serverowned ${MY_HTDOCSDIR}/ui
	webapp_serverowned ${MY_HTDOCSDIR}/zap
	# Make sure all the empty directories are kept.
	keepdir ${MY_HTDOCSDIR}/attach
	keepdir ${MY_HTDOCSDIR}/list
	keepdir ${MY_HTDOCSDIR}/mbox
	keepdir ${MY_HTDOCSDIR}/message
	keepdir ${MY_HTDOCSDIR}/mindex
	keepdir ${MY_HTDOCSDIR}/search
	keepdir ${MY_HTDOCSDIR}/splash
	keepdir ${MY_HTDOCSDIR}/thread
	keepdir ${MY_HTDOCSDIR}/ui
	keepdir ${MY_HTDOCSDIR}/zap

	# Declare config files so they are not hardlinked
	webapp_configfile ${MY_HOSTROOTDIR}/lurker.conf
	webapp_postinst_txt en INSTALL
	webapp_src_install
}

pkg_postinst() {
	ewarn "The lurker.conf file will be installed into your "
	ewarn "document root directory for the virtual host."
	ewarn "use the command:"
	ewarn "webapp-config -I -d / -h lurker.example.org lurker 2.1"
	ewarn "to install lurker for each virtual host and then edit"
	ewarn "the lurker.conf file for that host."
	ewarn
	ewarn "You should also have access control in place over the"
	ewarn "lurker website. There is a sample apache configuration"
	ewarn "file in /etc/lurker/apache.conf that you could include"
	ewarn "in your apache configuration."
}
