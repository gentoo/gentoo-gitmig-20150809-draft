# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/viewcvs/viewcvs-0.9.2_p20041207.ebuild,v 1.1 2004/12/07 15:01:33 stuart Exp $

PDATE=${PV/0.9.2_p/}
DESCRIPTION="Viewcvs, a web interface to cvs and subversion"
HOMEPAGE="http://viewcvs.sourceforge.net/"
SRC_URI="mirror://gentoo/${PN}-${PDATE}.tar.bz2"

LICENSE="viewcvs"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="|| ( ( >=app-text/rcs-5.7
	>=dev-util/cvs-1.11 )
	dev-util/subversion )
	sys-apps/diffutils
	net-www/apache"
S=${WORKDIR}/${PN}

WWW="/var/www/localhost/viewcvs"
CONFFILE="/etc/viewcvs/viewcvs.conf"

doinstall() {
	# start_location=$1
	# end_location=$2
	# mode=$3
	if [ -d $1 ]; then
		install -o root -d ${D}/$2
		for f in ${1}/*
		do
			doinstall ${f} ${f/${1}/${2}} $3
		done
	else
		sed -e "{ s,\(^#!.*$\),#!/usr/bin/python,; \
		s,\(<VIEWCVS_INSTALL_DIRECTORY>\),${WWW},; \
		s,\(^LIBRARY_DIR\)\(.*\$\),\1 = \"${WWW}/lib\",; \
		s,\(^CONF_PATHNAME\)\(.*\$\),\1 = \"${CONFFILE}\",}" ${1} >${1}.cpy

		install -o root -m $3 ${1}.cpy ${D}/$2
		rm ${1}.cpy
	fi
}

src_install() {
	cd ${S}
	install -o root -d ${D}/${WWW}/cgi

	doinstall www/cgi/viewcvs.cgi ${WWW}/cgi/viewcvs.cgi 755
	doinstall www/cgi/query.cgi ${WWW}/cgi/query.cgi 755
	doinstall standalone.py ${WWW}/standalone.py 755
	mkdir -p ${D}/`dirname ${CONFFILE}`
	doinstall viewcvs.conf.dist ${CONFFILE} 644
	doinstall cvsgraph.conf.dist `dirname ${CONFFILE}`/cvsgraph.conf 644
	doinstall tools/loginfo-handler ${WWW}/loginfo-handler 755
	doinstall tools/cvsdbadmin ${WWW}/cvsdbadmin 755
	doinstall tools/make-database ${WWW}/make-database 755

	doinstall lib ${WWW}/lib 644
	doinstall templates `dirname ${CONFFILE}`/templates 644

	dohtml -r website/*
	dosym /usr/share/doc/${PF}/html /etc/viewcvs/doc

	cat <<EOF >apache.conf
ScriptAlias /viewcvs /var/www/localhost/viewcvs/cgi/viewcvs.cgi
ScriptAlias /cvsquery /var/www/localhost/viewcvs/cgi/cvsquery.cgi

<Directory /var/www/localhost/viewcvs/cgi>
	Options ExecCGI
	<IfModule mod_access.c>
		Order allow,deny
		Allow from all
	</IfModule>
</Directory>
EOF
	dodoc INSTALL TODO CHANGES README apache.conf
}

pkg_postinst() {
	ewarn "Before using viewcvs make sure you configure it correctly"
	einfo "There is a sample apache integration configuration file in the"
	einfo "documentation directory named: apache.conf"
}
