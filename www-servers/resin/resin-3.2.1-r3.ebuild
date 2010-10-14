# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/resin/resin-3.2.1-r3.ebuild,v 1.5 2010/10/14 20:44:04 caster Exp $

EAPI="2"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 eutils flag-o-matic multilib autotools

DESCRIPTION="A fast Servlet 2.5 and JSP 2.0 engine."
HOMEPAGE="http://www.caucho.com"
SRC_URI="http://www.caucho.com/download/${P}-src.zip
	mirror://gentoo/resin-gentoo-patches-${PV}-r1.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE="admin"

KEYWORDS="amd64 x86"

	## java-virtuals/jaf"
COMMON_DEP="~dev-java/resin-servlet-api-${PV}
	dev-java/glassfish-deployment-api:1.2
	java-virtuals/javamail"

RDEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	dev-java/ant-core
	dev-libs/openssl
	${COMMON_DEP}"

RESIN_HOME="/usr/$(get_libdir)/resin"

# Rewrites build.xml in documentation
JAVA_PKG_BSFIX="off"

pkg_setup() {

	java-pkg-2_pkg_setup
	enewgroup resin
	enewuser resin -1 /bin/bash ${RESIN_HOME} resin

}

src_prepare() {

	for i in "${WORKDIR}"/${PV}/resin-${PV}-*; do
		epatch "${i}"
	done;

	java-ant_bsfix_one "${S}/build.xml"
	java-ant_bsfix_one "${S}/build-common.xml"

	sed -i -e 's/256m/384m/' "${S}/build.xml"

	eautoreconf

}

src_configure() {

	append-flags -fPIC -DPIC

	chmod 755 "${S}/configure"
	econf --prefix=${RESIN_HOME} || die "econf failed"

}

src_compile() {

	einfo "Building libraries..."
	# Broken with -jn where n > 1
	emake -j1 || die "emake failed"

	mkdir "${S}/lib"
	cd "${S}/lib"
	# java-pkg_jar-from --virtual jaf
	java-pkg_jar-from --virtual javamail
	# java-pkg_jar-from iso-relax
	# java-pkg_jar-from aopalliance-1
	java-pkg_jar-from glassfish-deployment-api-1.2
	java-pkg_jar-from resin-servlet-api-2.5
	ln -s $(java-config --jdk-home)/lib/tools.jar
	cd "${S}"

	einfo "Building jars..."
	eant || die "ant failed"

	if use doc; then
		einfo "Building docs..."
		eant doc || die "ant doc failed"
	fi

}

src_install() {

	make DESTDIR="${D}" install || die

	dodir /etc/
	mv "${D}/${RESIN_HOME}/conf" "${D}/etc/resin" || die "mv of conf failed"
	dosym /etc/resin ${RESIN_HOME}/conf

	keepdir /var/log/resin
	keepdir /var/log/resin
	keepdir /var/run/resin

	dosym /var/log/resin ${RESIN_HOME}/logs
	dosym /var/log/resin ${RESIN_HOME}/log

	dodoc README "${S}"/conf/*.xml

	newinitd "${FILESDIR}/${PV}/resin.init" resin
	newconfd "${FILESDIR}/${PV}/resin.conf" resin

	sed -i -e "s,__RESIN_HOME__,${RESIN_HOME},g" "${D}/etc/init.d/resin"

	rm -f "${S}/lib/tools.jar"
	java-pkg_dojar "${S}"/lib/*.jar
	rm -fr "${D}/${RESIN_HOME}/lib"
	dosym /usr/share/resin/lib ${RESIN_HOME}/lib
	dosym /var/log/resin /usr/share/resin/log

	dodir /var/lib/resin/webapps
	keepdir /var/lib/resin/hosts
	mv "${D}"/${RESIN_HOME}/webapps/* "${D}/var/lib/resin/webapps" || \
		die "mv of webapps failed"
	rm -rf "${D}/${RESIN_HOME}/webapps"
	dosym /var/lib/resin/webapps ${RESIN_HOME}/webapps
	dosym /var/lib/resin/hosts ${RESIN_HOME}/hosts

	use admin && {
		cp -a "${S}/doc/admin" "${D}/var/lib/resin/webapps/" || die "cp failed"
	}

	use source && {
		einfo "Zipping source..."
		java-pkg_dosrc "${S}"/modules/*/src/* 2> /dev/null
	}

	einfo "Removing unneeded files..."
	rm -fr "${D}/${RESIN_HOME}/bin"
	rm -fr "${D}/${RESIN_HOME}/doc"
	rm -f "${D}"/etc/resin/*.orig

	einfo "Fixing permissions..."
	chown -R resin:resin "${D}${RESIN_HOME}"
	chown -R resin:resin "${D}/etc/resin"
	chown -R resin:resin "${D}/var/log/resin"
	chown -R resin:resin "${D}/var/lib/resin"
	chown -R resin:resin "${D}/var/run/resin"

	chmod 644 "${D}/etc/conf.d/resin"
	chmod 755 "${D}/etc/init.d/resin"
	chmod 750 "${D}/var/lib/resin"
	chmod 750 "${D}/var/run/resin"
	chmod 750 "${D}/etc/resin"

}

pkg_postinst() {

	elog
	elog " User and group 'resin' have been added."
	elog
	elog " By default, Resin runs on port 8080. You can change this"
	elog " value by editing /etc/resin/resin.xml."
	elog
	elog " webapps directory was moved to /var/lib/resin/webapps"
	elog
	elog " Most options has been moved from /etc/conf.d/resin to"
	elog " /etc/resin/resin.xml."
	elog

}
