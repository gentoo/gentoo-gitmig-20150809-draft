# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-1.1_beta.ebuild,v 1.4 2003/04/19 19:55:45 sethbc Exp $

IUSE="kde gnome"

inherit virtualx

# NOTE:  There are two big issues that should be addressed.
#
#        1)  Language support and fonts should be addressed.

LOC="/opt"

INSTDIR="${LOC}/OpenOffice.org${PV}"
#MY_PV="`echo ${PV} | gawk '{ print tolower($1) }'`"
MY_PV="${PV/_/}"
if [ `use ppc` ]; then
	MY_P="OOo_${MY_PV}_LinuxPowerPC_installer"
S="${WORKDIR}/${MY_P}"
else
	MY_P="OOo_${MY_PV}_LinuxIntel_install" 
	S="${WORKDIR}/install"
fi;

DESCRIPTION="OpenOffice productivity suite"
SRC_URI="x86? ( http://ny1.mirror.openoffice.org/stable/${MY_PV}/OOo_${MY_PV}_LinuxIntel_install.tar.gz
		http://sf1.mirror.openoffice.org/stable/${MY_PV}/OOo_${MY_PV}_LinuxIntel_install.tar.gz )
 	 ppc? ( ftp://ftp.yellowdoglinux.com/pub/yellowdog/software/openoffice/OOo_${MY_PV}_LinuxPowerPC_installer.tar.gz )"
HOMEPAGE="http://www.openoffice.org"

DEPEND="virtual/glibc
	>=dev-lang/perl-5.0
	virtual/x11
	app-arch/zip
	app-arch/unzip
	|| ( >=virtual/jdk-1.3.1 >=virtual/jre-1.3.1 )
	!app-office/openoffice"

LICENSE="LGPL-2 | SISSL-1.1"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc "

src_install() {

	# Sandbox issues; bug #8587
	addpredict "/user"
	addpredict "/share"
	
	# Sandbox issues; bug 8063
	addpredict "/dev/dri"	

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
		DESTINATIONPATH=<home>/.openoffice/<pv>

		[JAVA]
		JavaSupport=none
	END_RS

	# Fixing install location in response file
	sed -e "s|<destdir>|${D}${INSTDIR}|" \
		${T}/rsfile-global > ${T}/autoresponse

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	cd ${S}
	# Setup virtualmake
	export maketype="./setup"
	# We need X to install...
	virtualmake "-v -r:${T}/autoresponse"

	#fix the libstdc++.so symlink
	cd ${D}/${INSTDIR}/program
	ln -sf libstdc++.so.3.0.4 libstdc++.so.3
	ln -sf libstdc++.so.3.0.4 libstdc++

	echo
	einfo "Removing build root from registry..."
	# Remove totally useless stuff.
	rm -f ${D}${INSTDIR}/program/{setup.log,sopatchlevel.sh}
	# Remove build root from registry and co
	egrep -rl "${D}" ${D}${INSTDIR}/* | \
		xargs -i perl -pi -e "s|${D}||g" {} || :

	einfo "Fixing permissions..."
	# Fix permissions
	find ${D}${INSTDIR}/ -type f -exec chmod a+r {} \;
	chmod a+x ${D}${INSTDIR}/share/config/webcast/*.pl

	# Fix symlinks
	for x in "soffice program/spadmin" \
		"program/setup setup" \
		"program/spadmin spadmin"
	do
		dosym $(echo ${x} | awk '{print $1}') \
			${INSTDIR}/$(echo ${x} | awk '{print $2}')
	done

	# Install user autoresponse file
	insinto /etc/openoffice
	sed -e "s|<pv>|${PV}|g" ${T}/rsfile-local > ${T}/autoresponse.conf
	doins ${T}/autoresponse.conf
	
	# Install wrapper script
	exeinto /usr/bin
	sed -e "s|<pv>|${PV}|g" \
		${FILESDIR}/${PV}/ooffice-wrapper-1.3 > ${T}/ooffice
	doexe ${T}/ooffice
	# Component symlinks
	dosym ooffice /usr/bin/oocalc
	dosym ooffice /usr/bin/oodraw
	dosym ooffice /usr/bin/ooimpress
	dosym ooffice /usr/bin/oomath
	dosym ooffice /usr/bin/oowriter
	dosym ooffice /usr/bin/oosetup
	dosym ooffice /usr/bin/oopadmin

	einfo "Installing Menu shortcuts (need \"gnome\" or \"kde\" in USE)..."
	if [ -n "`use gnome`" ]
	then
		insinto /usr/share/gnome/apps/OpenOffice.org
		# Install the files needed for the catagory
		doins ${D}${INSTDIR}/share/gnome/net/.directory
		doins ${D}${INSTDIR}/share/gnome/net/.order
		
		for x in ${D}${INSTDIR}/share/gnome/net/*.desktop
		do
			# We have to handle setup differently
			perl -pi -e "s:${INSTDIR}/program/setup:/usr/bin/oosetup:g" ${x}
			# Now fix the rest
			perl -pi -e "s:${INSTDIR}/program/s:/usr/bin/oo:g" ${x}
			doins ${x}
		done
	fi

	if [ -n "`use kde`" ]
	then
		local kdeloc="${D}${INSTDIR}/share/kde/net/applnk/OpenOffice.org${PV}"

		# Portage do not work with the space ..
		mv ${D}${INSTDIR}/share/kde/net/applnk/OpenOffice.org\ ${PV} ${kdeloc}
		
		insinto /usr/share/applnk/OpenOffice.org
		# Install the files needed for the catagory
		doins ${kdeloc}/.directory
		doins ${kdeloc}/.order
		dodir /usr/share
		# Install the icons and mime info
		cp -a ${D}${INSTDIR}/share/kde/net/mimelnk/share/* ${D}/usr/share
		
		for x in ${kdeloc}/*.desktop
		do
			# We have to handle setup differently
			perl -pi -e "s:${INSTDIR}/program/setup:/usr/bin/oosetup:g" ${x}
			# Now fix the rest
			perl -pi -e "s:${INSTDIR}/program/s:/usr/bin/oo:g" ${x}
			doins ${x}
		done
	fi

	# Unneeded, as they get installed into /usr/share...
	rm -rf ${D}${INSTDIR}/share/{cde,gnome,kde}

	for f in ${D}/usr/share/gnome/apps/OpenOffice.org/* ; do
		echo 'Categories=Application;Office;' >> ${f}
	done


	# Make sure these do not get nuked.
	keepdir ${INSTDIR}/user/config/registry/instance/org/openoffice/{Office,ucb}
	keepdir ${INSTDIR}/user/psprint/{driver,fontmetric}
	keepdir ${INSTDIR}/user/{autocorr,backup,plugin,store,temp,template}
}

pkg_preinst() {

	# The one with OO-1.0.0 was not valid
	if [ -f ${ROOT}/etc/openoffice/autoresponse.conf ]
	then
		rm -f ${ROOT}/etc/openoffice/autoresponse.conf
	fi
}

pkg_postinst() {
	
	einfo "******************************************************************"
	einfo " To start OpenOffice.org, run:"
	einfo
	einfo "   $ ooffice"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo "   oocalc, oodraw, ooimpress, oomath or oowriter"
	einfo
	einfo "******************************************************************"
}

