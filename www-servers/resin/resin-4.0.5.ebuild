# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/resin/resin-4.0.5.ebuild,v 1.2 2010/04/02 15:46:21 nelchael Exp $

EAPI="2"

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2 eutils flag-o-matic multilib autotools

DESCRIPTION="A fast Servlet and JSP engine."
HOMEPAGE="http://www.caucho.com"
SRC_URI="http://www.caucho.com/download/${P}-src.zip
	mirror://gentoo/resin-gentoo-patches-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE="admin"

KEYWORDS="~amd64 ~x86"

COMMON_DEP="~dev-java/resin-servlet-api-${PV}.3.0
	dev-java/glassfish-deployment-api:1.2
	java-virtuals/javamail
	dev-java/jsr101
	dev-java/mojarra:1.2"

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

	# No bundled JARs!
	rm -f "${S}/modules/ext/"*.jar
	rm -rf "${S}/project-jars"

	java-ant_bsfix_one "${S}/build.xml"
	java-ant_bsfix_one "${S}/build-common.xml"

	mkdir -p "${S}/m4"
	eautoreconf

	# Symlink our libraries:
	mkdir -p "${S}/gentoo-deps"
	cd "${S}/gentoo-deps/"
	java-pkg_jar-from --virtual javamail
	java-pkg_jar-from glassfish-deployment-api-1.2
	java-pkg_jar-from resin-servlet-api-3.0
	java-pkg_jar-from mojarra-1.2
	java-pkg_jar-from jsr101
	ln -s $(java-config --jdk-home)/lib/tools.jar
}

src_configure() {
	append-flags -fPIC -DPIC

	chmod 755 "${S}/configure"
	econf --prefix=${RESIN_HOME} || die "econf failed"
}

src_compile() {
	einfo "Building libraries..."
	emake || die "make failed"

	einfo "Building jars..."
	eant || die "ant failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

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

	dodir /usr/lib/resin/project-jars
	cp -a "${S}"/project-jars/*.jar "${D}/usr/lib/resin/project-jars"

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
