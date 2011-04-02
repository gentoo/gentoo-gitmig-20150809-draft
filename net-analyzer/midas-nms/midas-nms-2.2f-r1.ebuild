# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/midas-nms/midas-nms-2.2f-r1.ebuild,v 1.3 2011/04/02 12:53:17 ssuominen Exp $

inherit webapp depend.apache

DESCRIPTION="Monitoring, Intrusion Detection, Administration System"
SRC_URI="mirror://sourceforge/midas-nms/MIDAS-${PV}.tar.gz"
HOMEPAGE="http://midas-nms.sf.net"

LICENSE="MIT"
KEYWORDS="~ppc ~x86"

DEPEND="virtual/mysql
	net-libs/libpcap
	media-libs/gd"
RDEPEND="virtual/httpd-php"

need_apache

S="${WORKDIR}/MIDAS-${PV}"

pkg_setup() {
	webapp_pkg_setup
}

src_compile() {
	econf --sysconfdir=/etc/midas-nms || die "./configure failed"
	emake || die
}

src_install () {
	webapp_src_preinst

#	make DESTDIR=${D} install || die

	insinto /etc/midas-nms
	doins MIDASa/MIDASa.cf.dist
	doins MIDASb/MIDASb.cf.dist
	doins MIDASc/MIDASc.cf.dist
	doins MIDASd/MIDASd.cf.dist
	doins MIDASs/MIDASs.cf.dist
	doins MIDASn/MIDASn.cf.dist

	for each in a b c d n s
	do
	    dobin MIDAS${each}/MIDAS${each}
	done

	dodir /usr/share/midas-nms
	dodir /usr/share/midas-nms/sql
	insinto /usr/share/midas-nms/sql
	doins sql/* /usr/share/midas-nms/sql/

	# web
	doins -r MIDAS/* ${MY_HTDOCSDIR}
	webapp_serverowned ${MY_HTDOCSDIR}
	webapp_src_install

	# Install documentation.
	dodoc docs/CHANGELOG
	dodoc docs/INSTALL.txt

	# Init files
	newconfd "${FILESDIR}"/midas-nms.conf midas-nms
	newinitd "${FILESDIR}"/midas-nms.init midas-nms
}

pkg_postinst() {
	webapp_pkg_postinst

	elog
	elog "To install the web interface setup the app and copy"
	elog "${FILESDIR}/install.php to (adapt to your install root):"
	elog "http://localhost/midas-nms/install/install.php"
	elog
	elog "The conf files are located in /usr/etc/MIDAS*.cf.dist"
	elog "Please read INSTALL.txt for more info."
	elog
	elog "To use the sniffer and IDS you need install snort too."
	elog
}
