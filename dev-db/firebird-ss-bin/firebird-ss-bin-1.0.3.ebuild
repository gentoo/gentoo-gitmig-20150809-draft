# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/firebird-ss-bin/firebird-ss-bin-1.0.3.ebuild,v 1.1 2003/12/28 18:52:53 lostlogic Exp $
DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

LICENSE="MPL-1.1"

SLOT="0"

KEYWORDS="~x86"

HOMEPAGE="http://www.firebirdsql.com"

MY_PN="FirebirdSS"
MY_PV="${PV}.972-0"
MY_P="${MY_PN}-${MY_PV}"

SRC_URI="mirror://sourceforge/firebird/${MY_P}.tar.gz"
DESCRIPTION="Firebird SQL Super Server Binary"

S=${WORKDIR}/${MY_P}

src_install() {
	cd ${D}
	tar -zxvf ${S}/buildroot.tar.gz
	chown -R firebird:firebird ${D}/opt/interbase
	chmod ug+x ${D}/opt/interbase/bin/*
	insinto /etc/conf.d
	newins ${FILESDIR}/conf firebird
	exeinto /etc/init.d
	newexe ${FILESDIR}/init firebird
	exeinto /opt/interbase/bin
	newexe ${FILESDIR}/ibmgr ibmgr
}

pkg_preinst() {
	/etc/init.d/firebird stop 2> /dev/null
	userdel firebird 2> /dev/null
	if ! groupmod firebird; then
		groupadd firebird 2> /dev/null || die "Failed to create group"
	fi
	useradd -g firebird -s /dev/null -d /var/empty -c "firebird" firebird || \
		die "Failed to create firebird user"
}

pkg_postinst() {
	if ! grep 'localhost[[:space:]]*$' /etc/hosts.equiv > /dev/null; then
		echo localhost >> /etc/hosts.equiv
	fi
	if ! grep localhost.localdomain /etc/hosts.equiv > /dev/null; then
		echo localhost.localdomain >> /etc/hosts.equiv
	fi
	if ! grep gds_db /etc/services > /dev/null; then
		echo -e "#\n#Service added for gds_db (firebird)\n#" >> /etc/services
		echo "gds_db        3050/tcp" >> /etc/services

		einfo "added gds_db to /etc/services"
	fi
	/etc/init.d/firebird start
	chown firebird:firebird /opt/interbase
	chmod ug+x /opt/interbase/bin/*
}
