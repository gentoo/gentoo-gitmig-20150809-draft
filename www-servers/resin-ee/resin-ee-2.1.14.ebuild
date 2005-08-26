# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/resin-ee/resin-ee-2.1.14.ebuild,v 1.6 2005/08/26 13:36:18 flameeyes Exp $

inherit java-pkg eutils

DESCRIPTION="The Enterprise Edition of Resin"
SRC_URI="http://www.caucho.com/download/${P}.tar.gz"
HOMEPAGE="http://www.caucho.com"
KEYWORDS="~ppc ~sparc x86"
LICENSE="CAUCHO"
SLOT="0"
DEPEND="!www-servers/resin"
RDEPEND=">=virtual/jdk-1.2"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}/${PN}.diff
}

pkg_preinst() {
	enewgroup resin
	enewuser resin -1 /bin/bash /opt/resin resin
	chown -R resin:resin ${D}/opt/resin
	chown -R resin:resin ${D}/var/log/${PN}
}
src_compile() {	:; }

src_install() {
	cd ${S}
	RESIN_HOME="/opt/resin"
	diropts -m0755

	# Create directories
	dodir ${RESIN_HOME}
	dodir /var/log/${PN}
	dosym /var/log/${PN} ${RESIN_HOME}/logs
	keepdir /var/log/${PN}/

	# INIT SCRIPTS AND ENV
	newinitd ${FILESDIR}/${PV}/resin.init resin
	newconfd ${FILESDIR}/${PV}/resin.conf resin
	doenvd ${FILESDIR}/${PV}/21resin

	dodir /opt/resin || die
	dodoc LICENSE readme.txt

	java-pkg_dojar lib/*.jar

	cp -Rp \
		bin \
		doc \
		conf \
		contrib \
		webapps \
		xsl \
	${D}${RESIN_HOME} || die
	dosym /usr/share/${PN}/lib ${RESIN_HOME}/lib

	dodir /etc/env.d
	insinto /etc/env.d
	doins ${FILESDIR}/${PV}/21resin
}

pkg_postinst() {
	einfo
	einfo " NOTICE!"
	einfo " User and group 'resin' have been added."
	einfo
	einfo " FILE LOCATIONS:"
	einfo " 1.  Resin home directory: ${RESIN_HOME}"
	einfo "     Contains application data, configuration files."
	einfo " 2.  Runtime settings: /etc/conf.d/resin"
	einfo "     Contains CLASSPATH and JAVA_HOME settings."
	einfo " 3.  Logs:  /var/log/resin/"
	einfo " 4.  Executables, libraries:  /usr/share/resin-ee/"
	einfo
	einfo " STARTING AND STOPPING RESIN:"
	einfo "   /etc/init.d/resin start"
	einfo "   /etc/init.d/resin stop"
	einfo "   /etc/init.d/resin restart"
	einfo
	einfo " NETWORK CONFIGURATION:"
	einfo " By default, Resin runs on port 8080.  You can change this"
	einfo " value by editing ${RESIN_HOME}/conf/resin.conf."
	einfo
	einfo " To test Resin while it's running, point your web browser to:"
	einfo " http://localhost:8080/"
	einfo
	einfo " Be sure to allow Resin a minute or two to compile the pages"
	einfo " the first time you run it."
	einfo
	einfo " Resin cannot run on port 80 as non-root (as of this time)."
	einfo " The best way to get Resin to respond on port 80 is via port"
	einfo " forwarding -- by installing a firewall on the machine running"
	einfo " Resin or the network gateway.  Simply redirect port 80 to"
	einfo " port 8080."
	einfo
	einfo " BUGS:"
	einfo " Please file any bugs at http://bugs.gentoo.org/ or else it"
	einfo " may not get seen.  Thank you."
	einfo
}

pkg_postrm() {
	einfo "You may want to remove the resin user and group"
}
