# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/maya/maya-6.5.ebuild,v 1.3 2005/08/11 09:23:19 eradicator Exp $

inherit rpm eutils versionator

IUSE="bundled-libs maya-shaderlibrary doc"

S="${WORKDIR}"

DESCRIPTION="Alias Wavefront's Maya.  Commercial modeling and animation package."
HOMEPAGE="http://www.alias.com/eng/products-services/maya/index.shtml"

# RPM versions within the tarballs which will get installed
AWCOMMON_RPM="AWCommon-6.3-1.i686.rpm"
AWCOMMON_SERVER_RPM="AWCommon-server-6.3-1.i686.rpm"
MAYA_RPM="Maya6_5-6.5-253.i686.rpm"
MAYA_DOCS_RPM="Maya6_5-docs-6.5-253.i686.rpm"

# Patches to download go into SRC_URI
SRC_URI=""
RESTRICT="fetch nouserpriv"

SLOT="$(get_version_component_range 1-2)"

LICENSE="maya-5.0 mayadoc-5.0"

CDROM_NAME_1="Maya 6.5 Installation CD"

# Still having trouble getting the docs working right.
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip"

RDEPEND="|| ( app-shells/tcsh app-shells/csh )
	 x86? ( app-admin/fam
	        !bundled-libs? ( =x11-libs/qt-3*
	                         || ( sys-libs/libstdc++-v3 =sys-devel/gcc-3.3* )
	                         >=x11-libs/openmotif-2.2 ) )
	 amd64? ( >=app-emulation/emul-linux-x86-baselibs-2.1.4
	          app-emulation/emul-linux-x86-xlibs
	          !bundled-libs? ( app-emulation/emul-linux-x86-qtlibs ) )
	 doc? ( !bundled-libs? ( >=virtual/jre-1.4.2 ) )
	 virtual/opengl"

AWDIR="/opt/aw"
MAYADIR="${AWDIR}/maya${SLOT}"

pkg_nofetch() {
	einfo "Please place the required files in ${DISTDIR}:"
#	einfo
#	einfo "Downloads from Alias's support server:"
#	einfo "http://aliaswavefront.topdownloads.com/pub/bws/bws_107/myr_maya501_gold_linux_update.tgz"
#	einfo "http://aliaswavefront.topdownloads.com/pub/bws/bws_79/myr_TechDocs.zip"
}

src_unpack() {
	cdrom_get_cds AWCommon-${AWCOMMON_RPM}.rpm

	# Unpack downloaded tarballs containing RPMs
	#mkdir ${S}/RPMS
	#cd ${S}/RPMS
	#unpack myr_maya501_gold_linux_update.tgz

	# rpm_unpack unpacks in ${WORKDIR} no matter what we try... so get it out of the way...
	cd ${S}
	rpm_unpack ${CDROM_ROOT}/${AWCOMMON_RPM} || die
	rpm_unpack ${CDROM_ROOT}/${AWCOMMON_SERVER_RPM} || die
	rpm_unpack ${CDROM_ROOT}/${MAYA_RPM} || die

	if use doc ; then
		rpm_unpack ${CDROM_ROOT}/${MAYA_DOCS_RPM} || die

		if ! use bundled-libs; then
			rm -rf ${S}/usr/aw/maya6.5/docs/jre || die
			sed -i -e 's:JAVACMD=\./jre/bin/java:JAVACMD=java:g' ${S}/usr/aw/maya6.5/docs/startDocServer.sh || die
		fi
	fi

	if use maya-shaderlibrary ; then
		pushd ${CDROM_ROOT} >& /dev/null
		[[ -d shaderLibrary ]] || die "Could not locate shaderLibrary on Maya Installation CD."

		tar -c -f - shaderLibrary | (cd ${S}/usr/aw/maya${SLOT}; tar -x -f -) || die "Failed to copy over maya shader library"

		popd >& /dev/null
	fi

	# Use app-admin/flexlm
	rm -rf ${S}/usr/COM/{bin/lmutil,etc/lmgrd} || die

	# Don't need RedHat's init script
	rm -rf ${S}/etc || die

	mkdir ${S}/insroot || die
	mv ${S}/usr ${S}/insroot/opt || die
	rm -rf ${S}/insroot/opt/sbin || die

	cp -a ${CDROM_ROOT}/README.html ${S} || die

	# Remove unneeded libs (provided by RDEPEND).
	if ! use bundled-libs; then
		#rm -f ${S}/insroot/${AWDIR}/COM/lib/libXm.so.2.1 || die
		rm -f ${S}/insroot/${MAYADIR}/lib/libgcc_s.so.1 || die
		rm -f ${S}/insroot/${MAYADIR}/lib/libstdc++.so.5.0.6 || die

		# We keep this one because of possible C++ ABI changes...
		# Maya 6.5 was compiled with CXXABI_1.2 (libstdc++.so.5)
		# rm -f ${S}/insroot/${MAYADIR}/lib/libqt.so.3 || die

		rm -f ${S}/insroot/${MAYADIR}/lib/libXm.so.3 || die
	fi
}

src_install() {
	dohtml README.html

	cd ${S}/insroot
	cp -a . ${D} || die

	# We use our own Motif runtime unless USE=bundled-libs
	#if use bundled-libs; then
		dosym libXm.so.2.1 ${AWDIR}/COM/lib/libXm.so
		dosym libXm.so.2.1 ${AWDIR}/COM/lib/libXm.so.2
	#fi

	# SLOT the COM directory to avoid conflicts
	mv ${D}${AWDIR}/COM ${D}${AWDIR}/COM-${SLOT}
	dosym COM-${SLOT} ${AWDIR}/COM
	dosym COM ${AWDIR}/COM2
	# End rpm -qp --scripts AWCommon-6.3-1.i686.rpm

	# What follows is modified from rpm -qp --scripts Maya6_5-6.5-253.i686.rpm
	keepdir /var/flexlm

	dosym maya6.5 ${AWDIR}/maya

	# The RPM puts these in /usr/local/bin
	dosym Maya6.5 ${MAYADIR}/bin/maya

	dodir /usr/bin
	for mayaexec in Render fcheck imgcvt maya; do
		dosym ../../${AWDIR}/maya/bin/${mayaexec} /usr/bin/${mayaexec}
	done

	# links for pcw
	dosym libawcsprt.so.1 ${MAYADIR}/lib/libawcsprt.so
	dosym libpcw_opa.so.1 ${MAYADIR}/lib/libpcw_opa.so
	dosym libpcwfindkey.so.1 ${MAYADIR}/lib/libpcwfindkey.so
	dosym libpcwxml.so.1 ${MAYADIR}/lib/libpcwxml.so

	# We use our own gcc3 runtime unless USE=bundled-libs
	if use bundled-libs; then
		dosym libgcc_s.so.1 ${MAYADIR}/lib/libgcc_s.so
		dosym libstdc++.so.5.0.6 ${MAYADIR}/lib/libstdc++.so.5
		dosym libstdc++.so.5.0.6 ${MAYADIR}/lib/libstdc++.so
	fi

	# update the mental ray configuration files in place
	dosed "/\[PREFIX\]/s//\/opt/" ${MAYADIR}/mentalray/maya.rayrc
	dosed "/\[PREFIX\]/s//\/opt/" ${MAYADIR}/bin/mayarender_with_mr
	dosed "/\[PREFIX\]/s//\/opt/" ${MAYADIR}/bin/mayaexport_with_mr
	fperms 755 ${MAYADIR}/bin/mayarender_with_mr

	# End rpm -qp --scripts Maya6_5-6.5-253.i686.rpm

	doenvd ${FILESDIR}/50maya

	if use maya-shaderlibrary ; then
		echo "MAYA_SHADER_LIBRARY_PATH=\"${AWDIR}/maya/shaderLibrary/shaders\"" >> ${D}/etc/env.d/50maya
	fi

	# Fix permissions
	find ${D}${AWDIR} -type d -exec chmod 755 {} \;

	dosed 's:tail -1: tail -n 1:g' /opt/aw/maya${SLOT}/bin/Maya${SLOT}

	# For compatibility purposes.  Also, COM/bin/installKey uses
	# /usr/aw/COM/lib as runtime lib path to find libXm.so.2
	dosym ../opt/aw /usr/aw
}

pkg_postinst() {
	# What follows is modified from rpm -qp --scripts Maya6_5-6.5-253.i686.rpm
	cp ${ROOT}/etc/services ${T}/services.maya_save
	awk '/mi-ray/ { found++; print ; next } {print} END {if (0==found) print "mi-ray 7003/tcp" }' ${T}/services.maya_save > ${ROOT}/etc/services

	cp ${ROOT}/etc/services ${T}/services.maya_save
	awk '/mi-raysat/ { found++; print ; next } {print} END {if (0==found) print "mi-raysat 7103/tcp" }' ${T}/services.maya_save > ${ROOT}/etc/services

	# update the magic file 
	if [[ -e ${ROOT}/usr/share/magic ]]; then
		mv ${ROOT}/usr/share/magic ${T}/magic.rpmsave
		awk '/Alias.Wavefront Maya files. begin/ {p=1} /Alias.Wavefront Maya files. end/ {p=2} {if (p==2) { p=0} else if (p==0) print }' ${T}/magic.rpmsave > ${ROOT}/usr/share/magic
		cat ${ROOT}${MAYADIR}/.tmpdata/awmagic >> ${ROOT}/usr/share/magic;
		# get file to rebuild the cache 
		file -C > /dev/null 2>&1
		rm -Rf ${ROOT}${MAYADIR}/.tmpdata/awmagic 2>&1 > /dev/null
	fi
	# End rpm -qp --scripts Maya6_5-6.5-253.i686.rpm

	einfo "There may be a more recent license for this workstation available on the"
	einfo "Alias|Wavefront web site. Please visit the following URL to check for"
	einfo "updated licenses:"
	einfo "http://www.aliaswavefront.com/en/Community/Special/keys/maya/"
	echo
	einfo "To install your key, either place aw.dat in /var/flexlm or run the following"
	einfo "command from an X session:"
	einfo "${AWDIR}/COM/bin/installKey -input ${MAYADIR}/license_data/maya_prekey_data"
	echo
	einfo "One init scripts has been installed:"
	einfo "maya-docs is for the document server (help system)."
	echo
	einfo "If you want to use the flexlm license server, emerge '>=app-admin/flexlm-9.5'"
	echo

	# GCC_3.0
	# GLIBC_2.1.3
	# GLIBC_2.0
	# GLIBCPP_3.2
	# CXXABI_1.2
	einfo "Maya 6.5 was compiled on the following system configuration:"
	einfo "Linux 2.4.7-10 (RedHat 7.2, glibc-2.2.4-13), i686, gcc3"
	einfo "If you intend to compile plugins for Maya, you will need to"
	einfo "'emerge \=sys-devel/gcc-3.3*' and use gcc-config to switch compilers."
	einfo "The Maya SDK headers are located in ${MAYADIR}/include, and libs"
	einfo "are in ${MAYADIR}/lib."
	echo
	# http://www.highend2d.com/boards/showthreaded.php?Cat=&Board=linuxforum&Number=174726&page=&view=&sb=&o=
	ewarn "You should disable klipper, xfce4-clipman, and any other clipboard"
	ewarn "utilities as they have been shown to cause maya-5.0.1 to crash."
	ewarn "Feedback on whether or not this is still true ion Maya 6.5 would be"
	ewarn "appreciated at http://bugs.gentoo.org"

	if use doc && [[ ! -x /usr/bin/mozilla ]] ; then
		echo
		ewarn "The Maya document system has been installed, but we have detected"
		ewarn "that you don't have Mozilla installed on your system.  Maya"
		ewarn "launches mozilla to start the help program, so it is advised that"
		ewarn "you either install mozilla or place a stub executable at /usr/bin/mozilla"
		ewarn "which will launch another browser on your system."
	fi
}
