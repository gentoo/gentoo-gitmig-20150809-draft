# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-1.1.1.ebuild,v 1.18 2005/08/23 21:16:04 suka Exp $

# NOTE:  There are two big issues that should be addressed.
#
#        1)  Language support and fonts should be addressed.

LOC="/opt"

INSTDIR="${LOC}/OpenOffice.org"
MY_P="OOo_${PV}_LinuxIntel_install"
use ppc && MY_P="OOo_${PV}_LinuxPowerPC_en_installer"

S="${WORKDIR}/${MY_P}"

DESCRIPTION="OpenOffice productivity suite"
HOMEPAGE="http://www.openoffice.org/"
SRC_URI="x86? ( mirror://openoffice/stable/${PV}/OOo_${PV}_LinuxIntel_install.tar.gz )
	amd64? ( mirror://openoffice/stable/${PV}/OOo_${PV}_LinuxIntel_install.tar.gz )
	ppc? ( http://ftp.sunet.se/pub/Office/OpenOffice.org/contrib/linuxppc/OOo_${PV}_LinuxPowerPC_en_installer.tar.gz )"

LICENSE="|| ( LGPL-2  SISSL-1.1 )"
SLOT="0"
KEYWORDS="x86 ppc -sparc ~amd64"
IUSE="kde gnome"

DEPEND="sys-apps/findutils
	virtual/libc
	>=dev-lang/perl-5.0
	virtual/x11
	app-arch/zip
	app-arch/unzip
	|| ( >=virtual/jdk-1.3.1 >=virtual/jre-1.3.1 )
	!app-office/openoffice
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0 )"
RDEPEND="virtual/libc
	>=dev-lang/perl-5.0
	virtual/x11
	app-arch/zip
	app-arch/unzip
	|| ( >=virtual/jdk-1.3.1 >=virtual/jre-1.3.1 )
	!app-office/openoffice
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0 )"

PROVIDE="virtual/ooo"

src_install() {
	# Sandbox issues; bug #8587
	addpredict "/user"
	addpredict "/share"
	addpredict "/pspfontcache"
	addpredict "/usr/bin/soffice"
	addpredict "/root/.gconfd"

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

	# Autoresponse file for user installation
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
	./setup -nogui -v -r:${T}/autoresponse || die "The setup program failed"

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
	sed -e "s|<pv>|${PV}|g" ${T}/rsfile-local > ${T}/autoresponse-${PV}.conf
	doins ${T}/autoresponse-${PV}.conf

	# Install wrapper script
	exeinto /usr/bin
	sed -e "s|<pv>|${PV}|g" \
		${FILESDIR}/${PV}/ooffice-wrapper-1.3 > ${T}/ooffice
	doexe ${T}/ooffice

	# Component symlinks
	for app in calc draw impress math writer web setup padmin; do
		dosym ooffice /usr/bin/oo${app}
	done

	einfo "Installing Menu shortcuts (need \"gnome\" or \"kde\" in USE)..."
	if use gnome
	then
		insinto /usr/share/gnome/apps/OpenOffice.org
		# Install the files needed for the catagory
		doins ${D}${INSTDIR}/share/gnome/net/.directory
		doins ${D}${INSTDIR}/share/gnome/net/.order

		# Change this to ooo*.desktop from *.desktop for now, since
		# otherwise two sets of icons will appear in the GNOME menu.
		# <brad@gentoo.org> (04 Aug 2003)
		for x in ${D}${INSTDIR}/share/gnome/net/ooo*.desktop
		do
			# We have to handle soffice and setup differently
			perl -pi -e "s:${INSTDIR}/program/setup:/usr/bin/oosetup:g" ${x}
			perl -pi -e "s:${INSTDIR}/program/soffice:/usr/bin/ooffice:g" ${x}
			# Now fix the rest
			perl -pi -e "s:${INSTDIR}/program/s:/usr/bin/oo:g" ${x}
			doins ${x}
		done
	fi

	if use kde
	then
		local kdeloc="${D}${INSTDIR}/share/kde/net/"

		insinto /usr/share/applnk/OpenOffice.org\ 1.1
		# Install the files needed for the catagory
		doins ${kdeloc}/.directory
		dodir /usr/share
		# Install the icons and mime info
		cp -pPR ${D}${INSTDIR}/share/kde/net/share/mimelnk ${D}${INSTDIR}/share/kde/net/share/icons ${D}/usr/share

		for x in ${kdeloc}/*.desktop
		do
			# We have to handle soffice and setup differently
			perl -pi -e "s:${INSTDIR}/program/setup:/usr/bin/oosetup:g" ${x}
			perl -pi -e "s:${INSTDIR}/program/soffice:/usr/bin/ooffice:g" ${x}
			# Now fix the rest
			perl -pi -e "s:${INSTDIR}/program/s:/usr/bin/oo:g" ${x}
			doins ${x}
		done
	fi


	# Remove unneeded stuff
	rm -rf ${D}${INSTDIR}/share/cde

	# Make sure these do not get nuked.
	keepdir ${INSTDIR}/user/registry/res/en-us/org/openoffice/{Office,ucb}
	keepdir ${INSTDIR}/user/psprint/{driver,fontmetric}
	keepdir ${INSTDIR}/user/{autocorr,backup,plugin,store,temp,template}

	#touch files to make portage uninstalling happy (#22593)
	find ${D} -type f -exec touch {} \;
}

pkg_preinst() {

	# The one with OO-1.0.0 was not valid
	if [ -f ${ROOT}/etc/openoffice/autoresponse.conf ]
	then
		rm -f ${ROOT}/etc/openoffice/autoresponse.conf
	fi
}

pkg_postinst() {

	einfo " To start OpenOffice.org, run:"
	einfo
	einfo "   $ ooffice"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo "   oocalc, oodraw, ooimpress, oomath, ooweb or oowriter"
	einfo
}

