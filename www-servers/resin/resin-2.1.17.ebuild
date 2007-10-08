# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/resin/resin-2.1.17.ebuild,v 1.7 2007/10/08 12:51:15 nelchael Exp $

inherit java-pkg eutils

DESCRIPTION="A fast Servlet 2.3 and JSP 1.2 engine with EJB and distributed session load balancing."
SRC_URI="http://www.caucho.com/download/${P}.tar.gz"
HOMEPAGE="http://www.caucho.com"
KEYWORDS="amd64 ~ppc x86"
LICENSE="CAUCHO"
SLOT="0"
DEPEND="!www-servers/resin-ee"
RDEPEND=">=virtual/jdk-1.2
		dev-lang/perl"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}/${PN}.diff"
}

pkg_preinst() {
	enewgroup resin
	enewuser resin -1 /bin/bash /opt/resin resin
	chown -R resin:resin "${D}/opt/resin"
	chown -R resin:resin "${D}/var/log/${PN}"
}
src_compile() {	:; }

src_install() {
	cd "${S}"
	RESIN_HOME="/opt/resin"
	diropts -m0755

	# Create directories
	dodir ${RESIN_HOME}
	dodir /var/log/${PN}
	dosym /var/log/${PN} ${RESIN_HOME}/logs
	keepdir /var/log/${PN}/

	# INIT SCRIPTS AND ENV
	newinitd "${FILESDIR}/${PV}/resin.init" "${PN}"
	newconfd "${FILESDIR}/${PV}/resin.conf" "${PN}"
	doenvd "${FILESDIR}/${PV}/21resin"

	dodir /opt/resin || die
	dodoc LICENSE readme.txt

	java-pkg_dojar lib/*.jar

	cp -Rdp \
		bin \
		doc \
		conf \
		contrib \
		webapps \
		xsl \
	"${D}${RESIN_HOME}" || die
	dosym /usr/share/${PN}/lib ${RESIN_HOME}/lib
}

pkg_postinst() {
	elog
	elog " NOTICE!"
	elog " User and group 'resin' have been added."
	elog
	elog " FILE LOCATIONS:"
	elog " 1.  Resin home directory: ${RESIN_HOME}"
	elog "     Contains application data, configuration files."
	elog " 2.  Runtime settings: /etc/conf.d/resin"
	elog "     Contains CLASSPATH and JAVA_HOME settings."
	elog " 3.  Logs:  /var/log/resin/"
	elog " 4.  Executables, libraries:  /usr/share/resin/"
	elog
	elog " STARTING AND STOPPING RESIN:"
	elog "   /etc/init.d/resin start"
	elog "   /etc/init.d/resin stop"
	elog "   /etc/init.d/resin restart"
	elog
	elog " NETWORK CONFIGURATION:"
	elog " By default, Resin runs on port 8080.  You can change this"
	elog " value by editing ${RESIN_HOME}/conf/resin.conf."
	elog
	elog " To test Resin while it's running, point your web browser to:"
	elog " http://localhost:8080/"
	elog
	elog " Resin cannot run on port 80 as non-root (as of this time)."
	elog " The best way to get Resin to respond on port 80 is via port"
	elog " forwarding -- by installing a firewall on the machine running"
	elog " Resin or the network gateway.  Simply redirect port 80 to"
	elog " port 8080."
	elog
	elog " BUGS:"
	elog " Please file any bugs at http://bugs.gentoo.org/ or else it"
	elog " may not get seen.  Thank you."
	elog
}
