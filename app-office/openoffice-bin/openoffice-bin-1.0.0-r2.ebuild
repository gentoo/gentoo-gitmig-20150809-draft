# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-1.0.0-r2.ebuild,v 1.1 2002/07/15 18:51:54 azarah Exp $

# NOTE:  There are two big issues that should be addressed.
#
#        1)  The registry should be generated as done via "./setup -net",
#            and not via the tarball.
#
#        2)  Language support and fonts should be addressed.
#
#        It will also be good to generate regcomp via some other method.

MY_PV="`echo ${PV} | gawk '{ print toupper($1) }'`"
LOC="/opt"
MAIN_VER="`echo ${PV} |sed -e "s:[a-z]::g"`"
S="${WORKDIR}/install"
DESCRIPTION="OpenOffice productivity suite"
SRC_URI="http://ny1.mirror.openoffice.org/${PV}/OOo_${MY_PV}_LinuxIntel_install.tar.gz
	http://sf1.mirror.openoffice.org/${PV}/OOo_${MY_PV}_LinuxIntel_install.tar.gz
	http://www.ibiblio.org/gentoo/distfiles/openoffice-${PV}b-registry.tbz2"
HOMEPAGE="http://www.openoffice.org"

DEPEND="virtual/glibc
	>=sys-devel/perl-5.0
	virtual/x11
	app-arch/zip
	app-arch/unzip
	>=virtual/jdk-1.3.1"

SLOT="0"

src_unpack() {

	unpack OOo_${MY_PV}_LinuxIntel_install.tar.gz
}

src_install() {

	# Generate a install script
	PREFIX=${D}
	REGCOMP=${S}/regcomp
	INSTDIR=${S}
	DESTDIR=${D}${LOC}/OpenOffice-${PV}
	export PREFIX REGCOMP INSTDIR DESTDIR
	export RUNARGS="install"
	${FILESDIR}/${PV}/read_ins.pl >${S}/gentoo-install.sh || die
	chmod 0755 ${S}/gentoo-install.sh

	# Generate a register and createdb scripts
	PREFIX=""
	REGCOMP=${LOC}/OpenOffice-${PV}/program/regcomp
	INSTDIR=${S}
	DESTDIR=${LOC}/OpenOffice-${PV}
	export PREFIX REGCOMP INSTDIR DESTDIR
	export RUNARGS="register"
	${FILESDIR}/${PV}/read_ins.pl >${S}/gentoo-register.sh || die
	chmod 0755 ${S}/gentoo-register.sh
	export RUNARGS="createdb"
	${FILESDIR}/${PV}/read_ins.pl >${S}/gentoo-createdb.sh || die
	chmod 0755 ${S}/gentoo-createdb.sh

	# Install to ${D}
	${S}/gentoo-install.sh || die "Failed to install data to ${D}!"

	# Install regcomp.  For this we need to compile OO without
	# CFLAGS/CXXFLAGS.  I dont know when the config server API may
	# change, so this included regcomp may not work for future
	# versions of OO.
	cd ${D}${LOC}/OpenOffice-${PV}/program
	tar -jxf ${FILESDIR}/${PV}/regcomp-${PV}.tbz2 || \
		die "Could not unpack regcomp!"

	# Unpack the registry needed for NETWORK installation.
	# This my need to be updated for future versions of OO.
	# Install binary with "./setup -net" to generate.
	cd ${D}${LOC}/OpenOffice-${PV}/share/config/registry
	rm -rf *
	tar -jxpf ${DISTDIR}/openoffice-${PV}b-registry.tbz2 || \
		die "Could not unpack registry!"
	# Fix paths
	cd ${D}${LOC}/OpenOffice-${PV}/share/config/registry/instance/org/openoffice/Office
	cp Common.xml Common.xml.orig
	sed -e "s:/opt/OpenOffice\.org1\.0:${LOC}/OpenOffice-${PV}:g" \
		Common.xml.orig >Common.xml
	rm -f Common.xml.orig

	# Generate ISO resource files.
	cd ${D}${LOC}/OpenOffice-${PV}/program/resource
	for x in ooo*.res
	do
		cp ${x} ${x/ooo/iso}
	done

	# Create the global fonts.dir file
	cd ${D}${LOC}/OpenOffice-${PV}/share/fonts/truetype
	cp -f fonts.dir  fonts_dir.global

	# Create misc directories
	cd ${D}${LOC}/OpenOffice-${PV}
	mkdir -p user/config/registry/instance/org/openoffice/{Office,ucb}
	mkdir -p user/psprint/{driver,fontmetric}
	mkdir -p user/{autocorr,backup,plugin,store,temp,template}

	# Move the register and createdb scripts to ${D}
	cp -f ${S}/gentoo-register.sh ${D}${LOC}/OpenOffice-${PV}/program
	cp -f ${S}/gentoo-createdb.sh ${D}${LOC}/OpenOffice-${PV}/program
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		for x in bootstraprc configmgrrc instdb.ins sofficerc unorc
		do
			if [ -e ${LOC}/OpenOffice-${PV}/program/${x} ]
			then
				rm -f ${LOC}/OpenOffice-${PV}/program/${x} >/dev/null
			fi
		done
		${LOC}/OpenOffice-${PV}/program/gentoo-createdb.sh || die
		echo ">>> Registering components (this may take a few minutes)..."
		${LOC}/OpenOffice-${PV}/program/gentoo-register.sh &>/dev/null || die
	fi

	# Make sure these do not get nuked.
	cd ${ROOT}${LOC}/OpenOffice-${PV}
	mkdir -p user/config/registry/instance/org/openoffice/{Office,ucb}
	mkdir -p user/psprint/{driver,fontmetric}
	mkdir -p user/{autocorr,backup,plugin,store,temp,template}
}

