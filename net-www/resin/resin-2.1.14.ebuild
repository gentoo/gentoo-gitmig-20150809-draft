# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/resin/resin-2.1.14.ebuild,v 1.1 2004/07/27 20:22:22 axxo Exp $

inherit java-pkg eutils

S=${WORKDIR}/${P}
DESCRIPTION="A fast Servlet 2.3 and JSP 1.2 engine with EJB and distributed session load balancing."
SRC_URI="http://www.caucho.com/download/${P}.tar.gz"
HOMEPAGE="http://www.caucho.com"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
LICENSE="CAUCHO"
SLOT="0"
DEPEND="!net-www/resin-ee"
RDEPEND=">=virtual/jdk-1.2
		dev-lang/perl"
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

	cp -a ${FILESDIR}/${PV}/resin.init ${S}/resin
	insinto /etc/init.d
	insopts -m0750
	doins ${S}/resin

	cp -a ${FILESDIR}/${PV}/resin.conf ${S}/resin
	insinto /etc/conf.d
	insopts -m0755
	doins ${S}/resin

	cp -a ${FILESDIR}/${PV}/21resin ${S}/21resin
	insinto /etc/env.d
	insopts -m0755
	doins ${S}/21resin

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
	${D}${RESIN_HOME} || die
	dosym /usr/share/${PN}/lib ${RESIN_HOME}/lib

	dodir /etc/env.d
	insinto /etc/env.d
	doins ${FILESDIR}/${PV}/21resin
}

pkg_postinst() {
	einfo " "
	einfo " NOTICE!"
	einfo " User and group 'resin' have been added."
	einfo " "
	einfo " FILE LOCATIONS:"
	einfo " 1.  Resin home directory: ${RESIN_HOME}"
	einfo "     Contains application data, configuration files."
	einfo " 2.  Runtime settings: /etc/conf.d/resin"
	einfo "     Contains CLASSPATH and JAVA_HOME settings."
	einfo " 3.  Logs:  /var/log/resin/"
	einfo " 4.  Executables, libraries:  /usr/share/resin/"
	einfo " "
	einfo " "
	einfo " STARTING AND STOPPING RESIN:"
	einfo "   /etc/init.d/resin start"
	einfo "   /etc/init.d/resin stop"
	einfo "   /etc/init.d/resin restart"
	einfo " "
	einfo " "
	einfo " NETWORK CONFIGURATION:"
	einfo " By default, Resin runs on port 8080.  You can change this"
	einfo " value by editing ${RESIN_HOME}/conf/resin.conf."
	einfo " "
	einfo " To test Resin while it's running, point your web browser to:"
	einfo " http://localhost:8080/"
	einfo " "
	einfo " Resin cannot run on port 80 as non-root (as of this time)."
	einfo " The best way to get Resin to respond on port 80 is via port"
	einfo " forwarding -- by installing a firewall on the machine running"
	einfo " Resin or the network gateway.  Simply redirect port 80 to"
	einfo " port 8080."
	einfo " "
	einfo " BUGS:"
	einfo " Please file any bugs at http://bugs.gentoo.org/ or else it"
	einfo " may not get seen.  Thank you."
	einfo " "
}

pkg_postrm() {
	einfo "You may want to remove the resin user and group"
}

