# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-1.0.0-r3.ebuild,v 1.2 2002/09/15 16:00:42 azarah Exp $

inherit virtualx

# NOTE:  There are two big issues that should be addressed.
#
#        1)  Language support and fonts should be addressed.

MY_PV="`echo ${PV} | gawk '{ print toupper($1) }'`"
LOC="/opt"
S="${WORKDIR}/install"
DESCRIPTION="OpenOffice productivity suite"
SRC_URI="x86? ( http://ny1.mirror.openoffice.org/${PV}/OOo_${MY_PV}_LinuxIntel_install.tar.gz
	http://sf1.mirror.openoffice.org/${PV}/OOo_${MY_PV}_LinuxIntel_install.tar.gz )"
HOMEPAGE="http://www.openoffice.org"

DEPEND="virtual/glibc
	>=sys-devel/perl-5.0
	virtual/x11
	app-arch/zip
	app-arch/unzip
	>=virtual/jdk-1.3.1"

LICENSE="LGPL-2 | SISSL-1.1"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -sparc64"

src_unpack() {

	unpack OOo_${MY_PV}_LinuxIntel_install.tar.gz
}

src_install() {

	# Autoresponse file for main installation
	cat > ${T}/rsfile-global <<-"END_RS"
		[ENVIRONMENT]
		INSTALLATIONMODE=INSTALL_NETWORK
		INSTALLATIONTYPE=STANDARD
		DESTINATIONPATH=<destdir>
		OUTERPATH=
		LOGFILE=
		LANGUAGELIST=<LANGUAGE>

		[JAVA]
		JavaSupport=preinstalled_or_none
	END_RS
	
	# Autoresponse file for user isntallation
	cat > ${T}/rsfile-local <<-"END_RS"
		[ENVIRONMENT]
		INSTALLATIONMODE=INSTALL_WORKSTATION
		INSTALLATIONTYPE=WORKSTATION
		DESTINATIONPATH=<home>/.openoffice

		[JAVA]
		JavaSupport=none
	END_RS

	# Fixing install location in response file
	sed -e "s|<destdir>|${D}${LOC}/OpenOffice-${PV}|" \
		${T}/rsfile-global > ${T}/autoresponse

	einfo "Installing into build root..."
	dodir ${LOC}/OpenOffice-${PV}
	cd ${S}
	export maketype="./setup"
	virtualmake "-v -r:${T}/autoresponse"

	echo
	einfo "Removing build root from registy..."
	# Remove totally useless stuff.
	rm -f ${D}${LOC}/OpenOffice-${PV}/program/{setup.log,sopatchlevel.sh}
	# Remove build root from registry and co
	egrep -rl "${D}" ${D}${LOC}/OpenOffice-${PV}/* | \
		xargs -i perl -pi -e "s|${D}||g" {} || :

	einfo "Fixing permissions..."
	# Fix permissions
	find ${D}${LOC}/OpenOffice-${PV}/ -type f -exec chmod ag+r {} \;

	# Fix symlinks
	for x in "soffice program/spadmin" \
		"program/setup setup" \
		"program/spadmin spadmin"
	do
		dosym $(echo ${x} | awk '{print $1}') \
			${LOC}/OpenOffice-${PV}/$(echo ${x} | awk '{print $2}')
	done

	# Install user autoresponse file
	insinto /etc/openoffice
	newins ${T}/rsfile-local autoresponse.conf
}

pkg_postinst() {

	# Make sure these do not get nuked.
	cd ${ROOT}${LOC}/OpenOffice-${PV}
	keepdir ${ROOT}${LOC}/OpenOffice-${PV}/user/config/registry/instance/org/openoffice/{Office,ucb}
	keepdir ${ROOT}${LOC}/OpenOffice-${PV}/user/psprint/{driver,fontmetric}
	keepdir ${ROOT}${LOC}/OpenOffice-${PV}/user/{autocorr,backup,plugin,store,temp,template}
}

