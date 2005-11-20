# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/open-xchange/open-xchange-0.8.1.2.ebuild,v 1.8 2005/11/20 16:59:50 stuart Exp $

inherit eutils webapp ssl-cert toolchain-funcs java-pkg versionator depend.apache

MY_PV=$(replace_version_separator 3 '-')
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A Collaboration and Integration Server Environment"
HOMEPAGE="http://www.open-xchange.org/"
SRC_URI="http://mirror.open-xchange.org/download/${MY_P}.tar.bz2
	 http://www.mikefetherston.ca/OX/Crystal_OX_Theme.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86"
RESTRICT="primaryuri"

IUSE="ssl doc webdav mysql postgres"

S="${WORKDIR}/${MY_P}"

RDEPEND=">=virtual/jre-1.4
	 >=dev-java/java-config-1.2
	 >=www-servers/tomcat-5.0.27-r6
	 dev-perl/Net-SSLeay
	 dev-java/jdom
	 net-nds/openldap
	 app-text/ispell
	 dev-java/sun-javamail-bin
	 dev-perl/XML-NamespaceSupport
	 dev-perl/XML-SAX-Base
	 dev-perl/Authen-SASL
	 dev-perl/Convert-ASN1
	 dev-perl/perl-ldap
	 mysql? ( !postgres? ( dev-java/jdbc-mysql >=dev-db/mysql-4.1 ) )
	 !mysql? ( ~dev-java/jdbc3-postgresql-7.4.5 dev-db/postgresql )
	 postgres? ( ~dev-java/jdbc3-postgresql-7.4.5 dev-db/postgresql )
	 ssl? ( dev-libs/openssl dev-perl/IO-Socket-SSL )"

# COMMENT: Why is the jdbc requirement set to 7.4.5 and not >=7.4.5?

DEPEND="${RDEPEND}
	app-arch/zip
	>=virtual/jdk-1.4"

RDEPEND="${RDEPEND}
	 www-apache/mod_jk
	 app-admin/sudo"

use_postgres() {
	use postgres || ! use mysql
}

pkg_setup() {
	TOMCAT_DIR=`java-config -g CATALINA_HOME`
	if has_version '>=www-servers/tomcat-5.0.28-r4' ; then
		# it is now installed to the profile-directory choosen from /etc/conf.d/tomcat-5
		local PROFILE="$(sed -n "s:^PROFILE=\(.*\):\1:p" /etc/conf.d/tomcat-5)"
		local CATALINA_BASE="$(sed -n "s:^CATALINA_BASE=\(.*\)/$.*:\1:p" /etc/conf.d/tomcat-5)"
		SERVLETDIR="${CATALINA_BASE}/${PROFILE}/webapps"
	else
		SERVLETDIR="${TOMCAT_DIR}/webapps"
	fi

	webapp_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# http://www.open-xchange.org/cgi-bin/bugzilla/show_bug.cgi?id=734
	epatch ${FILESDIR}/${P}-login.patch

	# http://www.open-xchange.org/cgi-bin/bugzilla/show_bug.cgi?id=762
	epatch ${FILESDIR}/${P}-reply.patch

	# http://www.open-xchange.org/cgi-bin/bugzilla/show_bug.cgi?id=656
	sed -i "s|\${DESTDIR}|\$(DESTDIR)|g" Makefile.am

	export WANT_AUTOMAKE=1.8
	export WANT_AUTOCONF=2.5
	libtoolize --force --copy || die
	aclocal -I m4 || die
	automake -a -f -c || die
	autoheader || die
	autoconf || die

	# doing all preconfigure which can be done here
	# correct ispell-handling of german dictionary
	sed -i "s|-ddeutsch|-dgerman|g" conf/webmail/spellcheck.cfg

	if use ssl; then
		# change login.pm-script if ssl should be used
		sed -i "s|connection_mode = 3;|connection_mode = 2;|g" src/misc/login/login.pm.in
	fi

	# change image- and link- to the open-xchange location
	find groupware/ -regex '.*\.htm' |xargs sed -i "s|/cfintranet/|/open-xchange/cfintranet/|g"
	find templates/ -regex '.*\.htm' |xargs sed -i "s|/cfintranet/|/open-xchange/cfintranet/|g"
	find webmail/ -regex '.*\.htm' |xargs sed -i "s|/cfintranet/|/open-xchange/cfintranet/|g"

	find templates/ -regex '.*\.lang' |xargs sed -i "s|/cfintranet/|/open-xchange/cfintranet/|g"

	find system/www/ -regex '.*\.htm' |xargs sed -i "s|/cfintranet/|/open-xchange/cfintranet/|g"
	find system/www/ -regex '.*\.js' |xargs sed -i "s|/cfintranet/|/open-xchange/cfintranet/|g"

	sed -i "s|/cfintranet/|/open-xchange/cfintranet/|g" conf/groupware/system.properties.in
	sed -i "s|/cfintranet/|/open-xchange/cfintranet/|g" conf/webmail/system.properties.in
}

src_compile() {
	local myconf
	local tempvar

	if use_postgres ; then
		tempvar="$(java-config --classpath=$(java-config -l | sed -n "s:^\[\(jdbc[^-]*-postgresql[^]]*\).*:\1:p" | head -n 1))"
		if [[ -f "${tempvar}" && "${tempvar}" != "" ]]; then
			myconf="${myconf} --with-jdbcjar=$(java-config --classpath=$(java-config -l | sed -n "s:^\[\(jdbc[^-]*-postgresql[^]]*\).*:\1:p" | head -n 1))"
		else
			myconf="${myconf} --with-jdbcjar=/usr/share/jdbc3-postgresql/lib/jdbc3-postgresql.jar"
		fi
		myconf="${myconf} --with-dbdriver=org.postgresql.Driver"
	else
		tempvar="$(java-config --classpath=$(java-config -l | sed -n "s:^\[\(jdbc[^-]*-mysql[^]]*\).*:\1:p" | head -n 1))"
		if [[ -f "${tempvar}" && "${tempvar}" != "" ]]; then
			myconf="${myconf} --with-jdbcjar=$(java-config --classpath=$(java-config -l | sed -n "s:^\[\(jdbc[^-]*-mysql[^]]*\).*:\1:p" | head -n 1))"
		else
			myconf="${myconf} --with-jdbcjar=/usr/share/jdbc-mysql/lib/mysql-connector-java-3.0.11-stable-bin.jar"
		fi
		myconf="${myconf} --with-dbdriver=com.mysql.jdbc.Driver"
	fi

	myconf="${myconf} $(use_enable doc) $(use_enable webdav) $(use_enable ssl)"

	myconf="${myconf} --with-servletdir=${SERVLETDIR}"

#	if has_version '>=www-servers/tomcat-5.0.28-r4' ; then
		myconf="${myconf} --with-jsdkjar=${TOMCAT_DIR}/common/lib/servlet-api.jar"
#	else
#		myconf="${myconf} --with-jsdkjar=/usr/share/servletapi-2.4/lib/servlet-api.jar"
#	fi

	myconf="${myconf} --with-mailjar=/usr/share/sun-javamail-bin/lib/mail.jar"
	myconf="${myconf} --with-activationjar=/usr/share/sun-jaf-bin/lib/activation.jar"
	myconf="${myconf} --with-jdomjar=$(java-config --classpath=$(java-config -l | sed -n "s:^\[\(jdom[^]]*\).*:\1:p" | head -n 1))"
	myconf="${myconf} --with-xercesjar=/usr/share/xerces-2/lib/xercesImpl.jar"
	myconf="${myconf} --with-jni-dir=$(java-config -O)/include"
	myconf="${myconf} --with-runuid=tomcat"
	myconf="${myconf} --with-rungid=tomcat"
	myconf="${myconf} --with-tomcatuser=tomcat"
	myconf="${myconf} --with-htdocsdir=${MY_HTDOCSDIR}"
	myconf="${myconf} --with-cgibindir=${MY_CGIBINDIR}"
	myconf="${myconf} --sysconfdir=/etc/open-xchange"
	myconf="${myconf} --datadir=/usr/share/open-xchange"
	myconf="${myconf} --includedir=/usr/include/open-xchange"
	myconf="${myconf} --libdir=/usr/$(get_libdir)/open-xchange"
	myconf="${myconf} --localstatedir=/var/open-xchange"

	econf ${myconf} || die "bad ./configure"

	# replace the string "jikes" with "modern". We dont want to see all jikes warnings
	sed -i "s|jikes|modern|g" build.xml

	emake -j1 || die "make failed"

	# use sudo instead of su for the startup script and
	# correct var-log
	for foo in groupware sessiond webmail ; do
		sed -i "s:^\([\t ]*\)\(su \$USER.*$\):\1#\2:gI;s:^\([\t ]*\)#\(sudo -u \$USER.*\)$:\1\2:gI" system/etc/init.d/${foo}
		sed -i "s|open-xchange/log|log/open-xchange|g" system/etc/init.d/${foo}
	done

	sed -i "s|open-xchange/log|log/open-xchange|g" conf/groupware/system.properties
}

src_install() {
	webapp_src_preinst

	dodoc AUTHORS ChangeLog INSTALL NEWS README

	# Install this big thing
	cd ${S}
	make DESTDIR=${D} install || die "Failed on make install"

	# copy the ldif.in file for better config-abilities in pkg_preinst
	cp ${S}/system/setup/init_ldap.ldif.in ${D}/usr/share/open-xchange/init_ldap.ldif

	# remove obsolete log-files they should be saved in /var/log/open-xchange
	rm ${D}/var/open-xchange/log/groupware.log
	rm ${D}/var/open-xchange/log/jserv.log
	rm ${D}/var/open-xchange/log/sessiond.log
	rm ${D}/var/open-xchange/log/webmail.log
	rmdir ${D}/var/open-xchange/log/

	# create log-dir
	keepdir /var/log/open-xchange

	# remove unessary war-files, they are needed for deploying application
	rm ${D}/usr/lib/open-xchange/*.war

	# remove empty include-dir
	rmdir ${D}/usr/include/open-xchange/
	rmdir ${D}/usr/include/

	# remove unneeded init-script - not used by gentoo
	rm ${D}/etc/open-xchange/init.d/openexchange

	# Init script
	newinitd "${FILESDIR}/init.d.open-xchange" open-xchange || die "newinitd failed"

	if has_version '<www-servers/tomcat-5.0.28-r4' ; then
		dosed 's:tomcat-5:tomcat5:' /etc/init.d/open-xchange
	fi

	insinto ${SERVLETDIR}
	doins lib/*.war

	# chown of war-files or tomcat gets problems with stopping itself
	for x in umin.war servlet.war ; do
		fowners tomcat:tomcat ${SERVLETDIR}${x}
	done

	# Change default icon theme
	insinto ${MY_HTDOCSDIR}/cfintranet/images/top/EN/
	insopts -m0644
	doins ${WORKDIR}/*.png
	insinto ${MY_HTDOCSDIR}/cfintranet/images/top/DE/
	doins ${WORKDIR}/*.png

	# now mark all items with meta-info for webapp-script
	cd ${D}${MY_HTDOCSDIR}
	for x in $(find . -type f -print) ; do
		webapp_serverowned ${MY_HTDOCSDIR}/$x
	done

	# Put the schema in etc and symlink.  This way it's protected.
	dodir /etc/openldap/schema
	mv ${D}/usr/share/open-xchange/openxchange.schema ${D}/etc/openldap/schema
	dosym ../../../etc/openldap/schema/openxchange.schema /usr/share/open-xchange/openxchange.schema
	dosym ../../openldap/ldap.conf /etc/open-xchange/groupware/ldap.conf
	dosym ../../openldap/ldap.conf /etc/open-xchange/webmail/ldap.conf

	for x in settings/intranet settings/webmail filespool drafts webmailupload dictionary ; do
		keepdir /var/open-xchange/${x}
		fowners tomcat:tomcat /var/open-xchange/${x}
	done

	# Copy mod_jk file
	insinto ${APACHE2_MODULES_CONFDIR}
	doins ${FILESDIR}/88_mod_jk.ox.conf

	# copy ldap-aci-file
	insinto /etc/openldap/
	doins ${FILESDIR}/slapd.ox.inc

	# .htacces file
	insinto ${MY_HTDOCSDIR}
	newins ${FILESDIR}/${PN}-htaccess .htaccess

	# Install webapp
	webapp_src_install
}

pkg_preinst(){
	# create user mailadmin, needed for mailsupport
	enewuser mailadmin -1 -1 /dev/null users
	_UID=`getent passwd mailadmin | awk -F : '{print $3}'`

	# get the default guid of the group 'users'
	OX_STDGID=`getent group users | awk -F : '{print $3}'`

	# replace the SuSE group id 500 of users with the gentoo group id of the group 'users' for the mailadmin in ldif + uid
	sed -i "s|500|${OX_STDGID}|g" ${D}/usr/share/open-xchange/init_ldap.ldif
	sed -i "s|501|${_UID}|g" ${D}/usr/share/open-xchange/init_ldap.ldif

	# configuring admintools.conf

	# replace the SuSE standard group id 500 with the gentoo group id of the group 'users'
	sed -i "s|500|${OX_STDGID}|g" ${D}/etc/open-xchange/admintools.conf
	OX_STDGID=`expr ${OX_STDGID} + 1`
	sed -i "s|501|${OX_STDGID}|g" ${D}/etc/open-xchange/admintools.conf

	if use ssl ; then
		SSL_ORGANIZATION="${SSL_ORGANIZATION:-Open Xchange}"
		insinto /etc/open-xchange/groupware/sslcerts/oxCERTS
		docert groupware sessiond

		# copying the CA-certificate
		dodir /etc/open-xchange/groupware/sslcerts/oxCA
		cp ${T}/*ca.crt ${D}/etc/open-xchange/groupware/sslcerts/oxCA/cacert.pem

		# copying the groupware-key and -cert the way ox would like it to have
		mv ${D}/etc/open-xchange/groupware/sslcerts/oxCERTS/groupware.key ${D}/etc/open-xchange/groupware/sslcerts/oxCERTS/groupwarekey.pem
		mv ${D}/etc/open-xchange/groupware/sslcerts/oxCERTS/groupware.crt ${D}/etc/open-xchange/groupware/sslcerts/oxCERTS/groupwarecert.pem
		mv ${D}/etc/open-xchange/groupware/sslcerts/oxCERTS/groupware.csr ${D}/etc/open-xchange/groupware/sslcerts/oxCERTS/groupwarereq.pem
		mv ${D}/etc/open-xchange/groupware/sslcerts/oxCERTS/sessiond.key ${D}/etc/open-xchange/groupware/sslcerts/oxCERTS/sessiondkey.pem
		mv ${D}/etc/open-xchange/groupware/sslcerts/oxCERTS/sessiond.crt ${D}/etc/open-xchange/groupware/sslcerts/oxCERTS/sessiondcert.pem
		mv ${D}/etc/open-xchange/groupware/sslcerts/oxCERTS/sessiond.csr ${D}/etc/open-xchange/groupware/sslcerts/oxCERTS/sessiondreq.pem
		rm ${D}/etc/open-xchange/groupware/sslcerts/oxCERTS/sessiond.pem
		rm ${D}/etc/open-xchange/groupware/sslcerts/oxCERTS/groupware.pem
	fi
}

pkg_postinst() {
	webapp_pkg_postinst

	chgrp -R apache /var/open-xchange/*
	einfo
	einfo
	einfo " ==========================================================="
	einfo
	einfo "        You have successfully installed Open-Xchange"
	einfo
	einfo " ==========================================================="
	einfo
	einfo "   o FILE LOCATIONS"
	einfo "        1.  Configuration: /etc/open-xchange"
	einfo "        2.  HTML Files: 	  /usr/share/open-xchange"
	einfo
	einfo "   o STARTING and STOPPING the Open-Xchange"
	einfo "        /etc/init.d/openexchange start"
	einfo "        /etc/init.d/openexchange stop"
	einfo "        /etc/init.d/openexchange restart"
	einfo
	einfo "Execute the following command"
	einfo "ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo "to setup the initial open-xchange environment."
	einfo

	if has_version '=net-nds/openldap-2.1*' ; then
		ewarn "You have got OpenLDAP-2.1.* installed."
		ewarn "Please make sure you've got enabled aci support for this package."
		ewarn "For more information: http://gentoo-wiki.com/HOWTO_Open-Xchange#OpenLDAP"
		ewarn
		ewarn "If you already have this done, ignore this warning"
	fi
}

get_oxvar() {
	local var=$1
	more /etc/open-xchange/admintools.conf | sed -n "s:^\s*${var}=\"\(.*\)\":\1:p" | head -n 1
}

get_user_config() {
	local default=$1
	local desc=$2
	local read_val;

	echo -n "${desc}? [${default}] " 1>&2
	read readval
	if [[ -z ${readval} ]] ; then
		echo ${default}
	else
		echo ${readval}
	fi
}

pkg_config() {
	pkg_setup

	chown -R tomcat:tomcat ${ROOT}/etc/open-xchange

	if use ssl ; then
		chown -R tomcat:apache ${ROOT}/etc/open-xchange ${ROOT}/etc/open-xchange/groupware/sslcerts
		find ${ROOT}/etc/open-xchange/groupware/sslcerts -name '*.pem' -exec chmod 440 {} \;
	fi

	# Simple defaults
	local OX_DBHOST=${OX_DBHOST-"localhost"}
	local OX_DBNAME=${OX_DBNAME-"open_xchange"}
	local OX_DBUSER=${OX_DBUSER-"open_xchange"}
	local OX_DBPASS=${OX_DBPASS-"secret"}
	local OX_ORG=${OX_ORG-"My Organization"}
	local OX_DOMAIN=${OX_DOMAIN-"example.org"}
	local OX_LDAPSERVER=${OX_LDAPSERVER-"localhost"}
	local OX_BASEDN=${OX_BASEDN-"dc=example,dc=org"}
	local OX_ROOTDN=${OX_ROOTDN-"cn=Manager,${OX_BASEDN}"}
	local OX_ROOTPW=${OX_ROOTPW-"secret"}

	# Guess base on the installed config
	if [[ -e "${ROOT}/etc/open-xchange/admintools.conf" ]] ; then
		local temp_var
		echo "Installation of OX detected"

		temp_var=$(get_oxvar DEFAULT_SQL_HOST)
		[[ -n ${temp_var} ]] && OX_DBHOST=${temp_var}

		temp_var=$(get_oxvar DEFAULT_SQL_DB)
		[[ -n ${temp_var} ]] && OX_DBNAME=${temp_var}

		temp_var=$(get_oxvar DEFAULT_SQL_USER)
		[[ -n ${temp_var} ]] && OX_DBUSER=${temp_var}

		temp_var=$(get_oxvar DEFAULT_SQL_PASS)
		[[ -n ${temp_var} ]] && OX_DBPASS=${temp_var}

		temp_var=$(get_oxvar ORGA)
		[[ -n ${temp_var} ]] && OX_ORG=${temp_var}

		temp_var=$(get_oxvar BINDDN)
		[[ -n ${temp_var} ]] && OX_ROOTDN=${temp_var}

		temp_var=$(get_oxvar BINDPW)
		[[ -n ${temp_var} ]] && OX_ROOTPW=${temp_var}

		if [[ -e "${ROOT}/etc/open-xchange/groupware/ldap.conf" ]] ; then
			# taken from admintools.conf self
			temp_var=`grep -v '^#' ${ROOT}/etc/open-xchange/groupware/ldap.conf | grep -i BASE | head -n 1 | awk {'print $2'}`
			[[ -n ${temp_var} ]] && OX_BASEDN=${temp_var}
		fi
	fi

	# Now asking the user
	einfo "If values are correct just press enter else enter the new value"

	OX_DBHOST=$(get_user_config "${OX_DBHOST}" "Database Host")
	OX_DBNAME=$(get_user_config "${OX_DBNAME}" "Database Name")
	OX_DBUSER=$(get_user_config "${OX_DBUSER}" "Database User")
	OX_DBPASS=$(get_user_config "${OX_DBPASS}" "Database User's Password")
	OX_ORG=$(get_user_config "${OX_ORG}" "Organization")
	OX_DOMAIN=$(get_user_config "${OX_DOMAIN}" "Domain")
	OX_LDAPSERVER=$(get_user_config "${OX_LDAPSERVER}" "LDAP Server")
	OX_BASEDN=$(get_user_config "${OX_BASEDN}" "LDAP Base DN")
	OX_ROOTDN=$(get_user_config "${OX_ROOTDN}" "LDAP Root DN")
	OX_ROOTPW=$(get_user_config "${OX_ROOTPW}" "LDAP Root Password")

	einfo "Finished - now writing config"

	# patching umin.war, somehow dirty
	[[ -d "${T}/ox_war" ]] && rm -rf ${T}/ox_war
	mkdir -p ${T}/ox_war
	unzip ${ROOT}/${SERVLETDIR}/umin.war -d ${T}/ox_war

	sed -i "s|LDAP_SERVER=.*|LDAP_SERVER=${OX_LDAPSERVER}|g" ${T}/ox_war/WEB-INF/classes/oxuserminconfig.properties
	sed -i "s|LDAP_BASEDN=.*|LDAP_BASEDN=${OX_BASEDN}|g" ${T}/ox_war/WEB-INF/classes/oxuserminconfig.properties
	sed -i "s|SQL_SERVER_GROUPWARE=.*|SQL_SERVER_GROUPWARE=${OX_DBHOST}|g" ${T}/ox_war/WEB-INF/classes/oxuserminconfig.properties
	sed -i "s|SQL_SERVER_GROUPWARE_DATABASE_NAME=.*|SQL_SERVER_GROUPWARE_DATABASE_NAME=${OX_DBNAME}|g" ${T}/ox_war/WEB-INF/classes/oxuserminconfig.properties
	sed -i "s|SQL_SERVER_GROUPWARE_DATABASE_USERNAME=.*|SQL_SERVER_GROUPWARE_DATABASE_USERNAME=${OX_DBUSER}|g" ${T}/ox_war/WEB-INF/classes/oxuserminconfig.properties
	sed -i "s|SQL_SERVER_GROUPWARE_DATABASE_PASSWORD=.*|SQL_SERVER_GROUPWARE_DATABASE_PASSWORD=${OX_DBPASS}|g" ${T}/ox_war/WEB-INF/classes/oxuserminconfig.properties
	sed -i "s|CSS_PATH=/cfintranet/css/stylesheet.css|CSS_PATH=/open-xchange/cfintranet/css/stylesheet.css|g" ${T}/ox_war/WEB-INF/classes/oxuserminconfig.properties

	cd ${T}/ox_war
	zip -r -9 umin.war *
	cp umin.war ${ROOT}/${SERVLETDIR}
	cd ${ROOT}
	rm -rf ${T}/ox_war

	## now create configs with the right values
	# starting with ldap
	sed -i "s|@basedn@|${OX_BASEDN}|g" ${ROOT}/usr/share/open-xchange/init_ldap.ldif
	sed -i "s|@domain@|${OX_DOMAIN}|g" ${ROOT}/usr/share/open-xchange/init_ldap.ldif
	sed -i "s|@organization@|${OX_ORG}|g" ${ROOT}/usr/share/open-xchange/init_ldap.ldif

	local OX_BASEDC="`echo ${OX_BASEDN} | sed -n 's:dc=\([-A-Za-z_]*\).*:\1:p'|head -n 1`"
	sed -i "s|@basedc@|${OX_BASEDC}|g" ${ROOT}/usr/share/open-xchange/init_ldap.ldif

	sed -i "s|ORGA=\".*\"|ORGA=\"${OX_ORG}\"|g" ${ROOT}/etc/open-xchange/admintools.conf
	sed -i "s|BINDDN=\".*\"|BINDDN=\"${OX_ROOTDN}\"|g" ${ROOT}/etc/open-xchange/admintools.conf
	sed -i "s|BINDPW=\".*\"|BINDPW=\"${OX_ROOTPW}\"|g" ${ROOT}/etc/open-xchange/admintools.conf
	sed -i "s|DEFAULT_SQL_HOST=\".*\"|DEFAULT_SQL_HOST=\"${OX_DBHOST}\"|g" ${ROOT}/etc/open-xchange/admintools.conf
	sed -i "s|DEFAULT_SQL_DB=\".*\"|DEFAULT_SQL_DB=\"${OX_DBNAME}\"|g" ${ROOT}/etc/open-xchange/admintools.conf
	sed -i "s|DEFAULT_SQL_USER=\".*\"|DEFAULT_SQL_USER=\"${OX_DBUSER}\"|g" ${ROOT}/etc/open-xchange/admintools.conf
	sed -i "s|DEFAULT_SQL_PASS=\".*\"|DEFAULT_SQL_PASS=\"${OX_DBPASS}\"|g" ${ROOT}/etc/open-xchange/admintools.conf

	# setup correct acis
	sed -i "s|@basedn@|${OX_BASEDN}|g" ${ROOT}/etc/openldap/slapd.ox.inc
	chown ldap:ldap ${ROOT}/etc/openldap/slapd.ox.inc

	# groupware : server.conf
	for f in /etc/open-xchange/groupware/server.conf /etc/open-xchange/webmail/server.conf ; do
		sed -i "s|NAS_CON_CLASS_NAME: jdbc:\(.*\)://.*|NAS_CON_CLASS_NAME: jdbc:\1://${OX_DBHOST}/${OX_DBNAME}|g" ${ROOT}/${f}
		sed -i "s|NAS_CON_USER:.*|NAS_CON_USER: ${OX_DBUSER}|g" ${ROOT}/${f}
		sed -i "s|NAS_CON_PASS:.*|NAS_CON_PASS: ${OX_DBPASS}|g" ${ROOT}/${f}
		sed -i "s|NAS_CON_PASS:.*|NAS_CON_PASS: ${OX_DBPASS}|g" ${ROOT}/${f}
	done

	correctfilespool
	echo
	echo
	einfo "======================"
	einfo "Finished configuration"
	einfo "======================"

	echo
	einfo "And set JAVA_OPTS in /etc/conf.d/tomcat5 (or tomcat-5):"
	einfo "JAVA_OPTS=\"-Dopenexchange.propfile=${ROOT}/etc/open-xchange/groupware/system.properties\""

	echo
	einfo "And setup /etc/conf.d/apache2"
	einfo "APACHE2_OPTS=\"-D JK\""

	echo
	einfo "And setup /etc/conf.d/postgresql"
	einfo "PGOPTS=\"-i\""

	# Tell the user how to propegate ldap and the db
	## at first automatially change config in init_ldap.ldif and configuration-files

	## create ox-dbuser
	echo
	einfo "HOWTO: Setup database (following commands)"
	einfo "++++++++++++++++++++++++++++++++++++++++++"

	if use_postgres ; then
		einfo "echo \"CREATE USER ${OX_DBUSER} WITH PASSWORD '${OX_DBPASS}' CREATEDB NOCREATEUSER\" | psql -h localhost -U postgres template1 -f -"
		einfo "echo \"CREATE DATABASE ${OX_DBNAME} WITH OWNER=${OX_DBUSER} ENCODING='UNICODE'\" | psql -h localhost -U postgres template1 -f -"
		einfo "psql -U ${OX_DBUSER} ${OX_DBNAME} < ${ROOT}/usr/share/open-xchange/init_database.sql"
		einfo "/usr/sbin/dbinit_ox"
	else
		# COMMENT: we should tell them how to setup mysql also...
		einfo "MySQL instructions coming soon..."
		# some pre information
		# add user
		# INSERT INTO user (Host, User, Password) VALUES ('localhost','${OX_DBUSER}',PASSWORD('${OX_DBPASS}'));
		# FLUSH PRIVILIGES;
		# add database
		# CREATE DATABASE ${OX_DBNAME};
	fi

	## initialise database with ox, after configurations have been changed	
	echo
	echo
	einfo "HOWTO: Setup OpenLDAP"
	ewarn "Please make sure to STOP slapd to maintain database consistency (from slapadd(8c))!!!"
	einfo "+++++++++++++++++++++++++++++++++"
	einfo "/etc/init.d/slapd stop"
	einfo
	einfo "Add this to /etc/openldap/slapd.conf:"
	einfo "include         /etc/openldap/schema/cosine.schema"
	einfo "include         /etc/openldap/schema/inetorgperson.schema"
	einfo "include         /etc/openldap/schema/misc.schema"
	einfo "include         /etc/openldap/schema/nis.schema"
	einfo "include         /etc/openldap/schema/openldap.schema"
	einfo "include         /etc/openldap/schema/openxchange.schema"
	einfo
	einfo "If you want an initial set of access rights (enables your user, editing their password, ...)"
	einfo "you should also add the following line:"
	einfo "include         /etc/openldap/slapd.ox.inc"
	einfo
	einfo "slapadd -l /usr/share/open-xchange/init_ldap.ldif"
	einfo
	einfo "/etc/init.d/slapd start"

	echo
	echo
	einfo "HOWTO: Add a group"
	einfo "++++++++++++++++++"
	einfo "This is suggested for correct webdav-access"
	einfo "/usr/sbin/addgroup_ox --group=NEWGROUPNAME"

	echo
	echo
	einfo "HOWTO: Add a user"
	einfo "+++++++++++++++++"
	einfo "/usr/sbin/adduser_ox --username=MYUSERNAME --password=MYPASSWORD --name=FORENAME --sname=SURENAME --maildomain=${OX_DOMAIN} --ox_timezone=\"Europe/Berlin\""
	einfo "Now you can add the user to a group."
	einfo "/usr/sbin/addusertogroup_ox --user=MYUSERNAME --group=NEWGROUPNAME"
	echo
	einfo "If you encounter any problems with this commands probably your ldap or database configuration is not correct"
	echo
	echo
	einfo "Web Access:"
	einfo "To access open-xchange via the web, point your browser to: http://localhost/cgi-bin/login.pl"
}
