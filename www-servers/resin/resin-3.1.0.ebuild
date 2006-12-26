# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/resin/resin-3.1.0.ebuild,v 1.1 2006/12/26 01:49:46 nelchael Exp $

inherit java-pkg-2 java-ant-2 eutils flag-o-matic

DESCRIPTION="A fast Servlet 2.5 and JSP 2.0 engine."
HOMEPAGE="http://www.caucho.com"
SRC_URI="http://www.caucho.com/download/${P}-src.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="admin doc source"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND="=virtual/jdk-1.5*
	>=dev-java/iso-relax-20050331"
DEPEND="${RDEPEND}
	dev-java/aopalliance
	>=dev-java/sun-javamail-1.4
	>=dev-java/sun-jaf-1.1
	dev-java/ant-core
	dev-libs/openssl"

RESIN_HOME="/usr/lib/resin"

# Rewrites build.xml in documentation
JAVA_PKG_BSFIX="off"

src_unpack() {

	unpack ${A}
	epatch "${FILESDIR}/${PV}/${P}-gentoo.patch"

	java-ant_bsfix_one "${S}/build.xml"

}

pkg_setup() {

	enewgroup resin
	enewuser resin -1 /bin/bash ${RESIN_HOME} resin

}

src_compile() {

	append-flags -fPIC -DPIC

	chmod 755 ${S}/configure
	econf --prefix=${RESIN_HOME} || die "econf failed"

	einfo "Building libraries..."
	# Broken with -jn where n > 1
	emake -j1 || die "emake failed"

	mkdir ${S}/lib
	cd ${S}/lib
	java-pkg_jar-from sun-jaf
	java-pkg_jar-from sun-javamail
	java-pkg_jar-from iso-relax
	java-pkg_jar-from aopalliance-1
	ln -s $(java-config --jdk-home)/lib/tools.jar
	cd ${S}

	einfo "Building jars..."
	eant || die "ant failed"

	if use doc; then
		einfo "Building docs..."
		eant doc || die "ant doc failed"
	fi

}

src_install() {

	make DESTDIR=${D} install || die

	dodir /etc/
	mv ${D}/${RESIN_HOME}/conf ${D}/etc/resin
	dosym /etc/resin ${RESIN_HOME}/conf

	keepdir /var/log/resin
	keepdir /var/log/resin
	keepdir /var/run/resin

	dosym /var/log/resin ${RESIN_HOME}/logs
	dosym /var/log/resin ${RESIN_HOME}/log

	dodoc README ${S}/conf/*.conf

	newinitd ${FILESDIR}/${PV}/resin.init resin
	newconfd ${FILESDIR}/${PV}/resin.conf resin

	rm -f ${S}/lib/tools.jar
	java-pkg_dojar ${S}/lib/*.jar
	rm -fr ${D}/${RESIN_HOME}/lib
	dosym /usr/share/resin/lib ${RESIN_HOME}/lib

	dodir /var/lib/resin/webapps
	mv ${D}/${RESIN_HOME}/webapps/* ${D}/var/lib/resin/webapps
	rm -rf ${D}/${RESIN_HOME}/webapps
	dosym /var/lib/resin/webapps ${RESIN_HOME}/webapps

	dosym /etc/resin/resin.conf /etc/resin/resin.xml

	use admin && {
		cp -a ${S}/php ${D}/${RESIN_HOME}/ || die "cp failed"
	}

	use source && {
		einfo "Zipping source..."
		java-pkg_dosrc ${S}/modules/*/src/* 2> /dev/null
	}

	einfo "Removing unneeded files..."
	rm -fr ${D}/${RESIN_HOME}/bin
	rm -f ${D}/etc/resin/*.orig

	einfo "Fixing permissions..."
	chown -R resin:resin ${D}${RESIN_HOME}
	chown -R resin:resin ${D}/etc/resin
	chown -R resin:resin ${D}/var/log/resin
	chown -R resin:resin ${D}/var/lib/resin
	chown -R resin:resin ${D}/var/run/resin

	chmod 755 ${D}${RESIN_HOME}/bin/*
	chmod 644 ${D}/etc/conf.d/resin
	chmod 755 ${D}/etc/init.d/resin
	chmod 750 ${D}/var/lib/resin
	chmod 750 ${D}/var/run/resin
	chmod 750 ${D}/etc/resin

}

pkg_postinst() {

	einfo
	einfo " User and group 'resin' have been added."
	einfo
	einfo " By default, Resin runs on port 8080.  You can change this"
	einfo " value by editing /etc/conf/resin.conf."
	einfo
	einfo " webapps directory was moved to /var/lib/resin/webapps"
	einfo
	einfo " Most options has been moved from /etc/conf.d/resin to"
	einfo " /etc/resin/resin.conf."
	einfo

}
