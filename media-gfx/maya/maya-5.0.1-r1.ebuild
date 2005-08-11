# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/maya/maya-5.0.1-r1.ebuild,v 1.14 2005/08/11 08:50:25 eradicator Exp $

# Note that this ebuild requires you to set the MAYA_INSTALL_LOC environment
# variable to the location of your maya RPMS and documentation:
# MAYA_INSTALL_LOC=/mnt/cdrom/LINUX is default
#
# This directory should contain something files that look like this:
#  -rw-rw-r--  1 root root  3503937 Mar 13  2003 AWCommon-5.3-5.i686.rpm
#  -rw-rw-r--  1 root root   346478 Mar 13  2003 AWCommon-server-5.3-5.i686.rpm
#  drwxr-xr-x  2 root root     2048 Apr  2  2003 LicenseMaya
#  -rw-rw-r--  1 root root 97444965 Apr  1  2003 Maya5_0-5.0-18.i686.rpm
#  -rwxrwxr-x  1 root root    28936 Apr  2  2003 README.html
#  drwxrwxr-x  4 root root     2048 Apr  2  2003 documentation
#  -rwxr-xr-x  1 root root     2404 Mar 18  2003 installDocs.sh
#  lrwxr-xr-x  1 root root       16 Apr  2  2003 shaderLibrary -> ../shaderLibrary
#  drwxr-xr-x  3 root root     2048 Apr  2  2003 support

inherit rpm eutils

IUSE="bundled-libs"
S="${WORKDIR}"

DESCRIPTION="Alias Wavefront's Maya.  Commercial modeling and animation package."
HOMEPAGE="http://www.alias.com/eng/products-services/maya/index.shtml"

SRC_URI="myr_maya501_gold_linux_update.tgz myr_TechDocs.zip"
RESTRICT="fetch"

# RPM versions within the tarballs which will get installed
AWCOMMON="5.3-5.i686"
AWCOMMON_SERVER="5.3-5.i686"
MAYA5_0="5.0.1-135.i686"

SLOT="5.0"

LICENSE="maya-5.0 mayadoc-5.0"
KEYWORDS="x86 ~amd64"

DEPEND="app-arch/unzip"

RDEPEND="|| ( app-shells/tcsh app-shells/csh )
	 x86? ( >=sys-libs/lib-compat-1.3
	        !bundled-libs? ( =x11-libs/qt-3*
	                         >=sys-devel/gcc-3
	                         >=x11-libs/openmotif-2.1.30 ) )
	 amd64? ( app-emulation/emul-linux-x86-baselibs
	          app-emulation/emul-linux-x86-xlibs
	          app-emulation/emul-linux-x86-qtlibs )
	 virtual/opengl"

pkg_nofetch() {
	einfo "Please place the required files and place them in ${DISTDIR}:"
	einfo
	einfo "Downloads from Alias's support server:"
	einfo "http://aliaswavefront.topdownloads.com/pub/bws/bws_107/myr_maya501_gold_linux_update.tgz"
	einfo "http://aliaswavefront.topdownloads.com/pub/bws/bws_79/myr_TechDocs.zip"
	einfo
	einfo "Additionally, you need to place the Maya 5 CD in the CD drive (we expect /mnt/cdrom)."
	einfo "If you don't use /mnt/cdrom or you have network installation files, then you need to set"
	einfo "the environment variable 'MAYA_INSTALL_LOC' to the directory containing AWCommon-5.3-5.i686.rpm,"
	einfo "AWCommon-server-5.3-5.i686.rpm, Maya5_0-5.0-18.i686.rpm, and documentation."
	einfo
}

src_unpack() {
	if [ -z "${MAYA_INSTALL_LOC}" ]; then
		cdrom_get_cds LINUX/AWCommon-${AWCOMMON}.rpm
		MAYA_INSTALL_LOC=${CDROM_ROOT}/LINUX
	fi

	if [ ! -d "${MAYA_INSTALL_LOC}" ]; then
		eerror "MAYA_INSTALL_LOC is not set to a valid location.  ${MAYA_INSTALL_LOC} is not a directory."
		die "Failure finding maya install files."
	fi

	cd ${MAYA_INSTALL_LOC}
	ebegin "Checking md5sum of files in ${MAYA_INSTALL_LOC}"
	md5sum -c ${FILESDIR}/${P}.md5sum
	if [ $? -ne 0 ]; then
		eend 1
		die "Failure checking md5sum of files in ${MAYA_INSTALL_LOC}.  If you are certain your CD is not corrupt, file a bug at http://bugs.gentoo.org, comment out the md5sum checking in the ebuild, and proceed at your own risk."
	fi
	eend 0

	mkdir ${S}/RPMS
	cd ${S}/RPMS
	unpack myr_maya501_gold_linux_update.tgz

	# rpm_unpack unpacks in ${WORKDIR} no matter what we try... so get it out of the way...
	cd ${S}
	rpm_unpack ${MAYA_INSTALL_LOC}/AWCommon-${AWCOMMON}.rpm
	rpm_unpack ${MAYA_INSTALL_LOC}/AWCommon-server-${AWCOMMON_SERVER}.rpm
	rpm_unpack ${S}/RPMS/Maya5_0-${MAYA5_0}.rpm

	mkdir ${S}/insroot
	mv ${S}/usr ${S}/insroot

	# Don't need their init script
	rm -rf etc

	# Remove unneeded libs (provided by DEPEND).
	if ! use bundled-libs; then
		rm -f ${S}/insroot/usr/aw/COM/lib/libXm.so.2.1
		rm -f ${S}/insroot/usr/aw/maya5.0/lib/libgcc_s.so.1
		rm -f ${S}/insroot/usr/aw/maya5.0/lib/libstdc++.so.5.0.2
		rm -f ${S}/insroot/usr/aw/maya5.0/lib/libqt.so.3
		rm -f ${S}/insroot/usr/aw/maya5.0/lib/libXm.so.2
	fi

	cp -a ${MAYA_INSTALL_LOC}/documentation ${MAYA_INSTALL_LOC}/README.html ${S}

	mkdir ${S}/docs.upgrade
	cd ${S}/docs.upgrade
	unpack myr_TechDocs.zip
}

src_install() {
	dohtml README.html

	cd ${S}/insroot
	cp -a . ${D}

	# What follows is modified from rpm -qp --scripts RPMS/AWCommon-5.3-5.i686.rpm
	for lmexec in lmcksum lmdiag lmdown lmhostid lmremove lmreread lmstat lmver; do
		dosym lmutil /usr/aw/COM/bin/${lmexec}
	done

	# We use our own Motif runtime unless USE=bundled-libs
	if use bundled-libs; then
		dosym libXm.so.2.1 libXm.so
		dosym libXm.so.2.1 libXm.so.2
	fi

	dosym COM /usr/aw/COM2
	# End rpm -qp --scripts RPMS/AWCommon-5.3-5.i686.rpm

	# What follows is modified from rpm -qp --scripts RPMS/Maya5_0-5.0.1-135.i686.rpm
	keepdir /var/flexlm
	fperms ugo+w /var/flexlm

	dosym maya5.0 /usr/aw/maya

	# The RPM puts these in /usr/local/bin
	keepdir /usr/bin
	dosym /usr/aw/maya5.0/bin/Maya5.0 /usr/aw/maya5.0/bin/maya
	for mayaexec in Render fcheck imgcvt maya; do
		dosym /usr/aw/maya5.0/bin/${mayaexec} /usr/bin/${mayaexec}
	done

	dosym Mayatomr.so /usr/aw/maya5.0/bin/plug-ins/Mayatomr.sog

	# We use our own gcc3 runtime unless USE=bundled-libs
	if use bundled-libs; then
		dosym libgcc_s.so.1 /usr/aw/maya5.0/lib/libgcc_s.so
		dosym libstdc++.so.5.0.2 /usr/aw/maya5.0/lib/libstdc++.so.5
		dosym libstdc++.so.5.0.2 /usr/aw/maya5.0/lib/libstdc++.so
	fi

	# update the mental ray configuration files in place
	dosed "/\[PREFIX\]/s//\/usr/" /usr/aw/maya5.0/mentalray/maya.rayrc
	dosed "/\[PREFIX\]/s//\/usr/" /usr/aw/maya5.0/bin/mayarender_with_mr
	dosed "/\[PREFIX\]/s//\/usr/" /usr/aw/maya5.0/bin/mentalrayrender
	dosed "/\[PREFIX\]/s//\/usr/" /usr/aw/maya5.0/bin/mayaexport_with_mr
	fperms 755 /usr/aw/maya5.0/bin/mayarender_with_mr /usr/aw/maya5.0/bin/mentalrayrender

	# End rpm -qp --scripts RPMS/Maya5_0-5.0.1-135.i686.rpm

	exeinto /etc/init.d
	doexe ${FILESDIR}/maya-docs ${FILESDIR}/aw_flexlm

	insinto /etc/conf.d
	newins ${FILESDIR}/aw_flexlm.conf.d aw_flexlm

	# Now for the docs stuff...
	cd ${S}/documentation
	addpredict /var/.com.zerog.registry.lock
	addwrite /var/.com.zerog.registry.xml
	einfo "Starting Maya 5.0 DocServer installation..."
	./Linux_Maya50Docs_Installer/installMayaDocServer.bin -DUSER_INSTALL_DIR="${D}/usr/aw/maya5.0/docs" -i silent
	einfo "Starting Maya 5.0 English Documentation installation..."
	./Linux_M5en_US_Installer/install_en_US_docs.bin -DUSER_INSTALL_DIR="${D}/usr/aw/maya5.0/docs/Documents" -i silent

	# And now the doc update
	cd ${S}/docs.upgrade
	insinto /usr/aw/maya5.0/docs/Documents/Maya5.0/en_US
	doins *.zip

	cd ${S}/docs.upgrade/style
	insinto /usr/aw/maya5.0/docs/Documents/Maya5.0/en_US/style
	doins *

	# Fix permissions
	find ${D}/usr/aw -type d -exec chmod 755 {} \;

	# Actually place everything in /opt since this is a binary package
	dodir /opt
	mv ${D}/usr/aw ${D}/opt
	dosym ../opt/aw /usr/aw
}

pkg_postinst() {
	# What follows is modified from rpm -qp --scripts RPMS/Maya5_0-5.0.1-135.i686.rpm
	cp /etc/services /tmp/services.maya_save
	awk '/mi-ray3_2maya5_0/ { found++; print ; next } {print} END {if (0==found) print "mi-ray3_2maya5_0 7054/tcp" }' /tmp/services.maya_save > /etc/service

	# update the magic file 
	if [ -e /usr/share/magic ]; then
		mv /usr/share/magic /tmp/magic.rpmsave
		awk '/Alias.Wavefront Maya files. begin/ {p=1} /Alias.Wavefront Maya files. end/ {p=2} {if (p==2) { p=0} else if (p==0) print }' /tmp/magic.rpmsave > /usr/share/magic
		cat /usr/aw/maya5.0/.tmpdata/awmagic >> /usr/share/magic;
		# get file to rebuild the cache 
		file -C > /dev/null 2>&1
		rm -Rf /usr/aw/maya5.0/.tmpdata/awmagic 2>&1 > /dev/null
	fi
	# End rpm -qp --scripts RPMS/Maya5_0-5.0.1-135.i686.rpm

	einfo "There may be a more recent license for this workstation available on the Alias|Wavefront"
	einfo "web site. Please visit the following URL to check for updated licenses:"
	einfo "http://www.aliaswavefront.com/en/Community/Special/keys/maya/"
	einfo
	einfo "To install your key, either place aw.dat in /var/flexlm or run the following command from an X session:"
	einfo "/usr/aw/COM/bin/installKey -input /usr/aw/maya5.0/license_data/maya_prekey_data"
	einfo
	einfo "Two init scripts have been installed:"
	einfo "maya-docs is for the document server (help system)."
	einfo "aw_flexlm is for the license server"
	einfo

	einfo "Maya 5.0.1 was compiled with gcc 3.0 and origionally linked against glibc 2.1.3.  If you intend to compile"
	einfo "plugins for Maya, you will need to 'emerge \=sys-devel/gcc-3.0*' and use gcc-config to switch compilers."
	einfo "The Maya SDK headers are located in /usr/aw/maya/include, and libs are in /usr/aw/maya/lib."
	einfo

	# http://www.highend2d.com/boards/showthreaded.php?Cat=&Board=linuxforum&Number=174726&page=&view=&sb=&o=
	ewarn "You should disable klipper, xfce4-clipman, and any other clipboard"
	ewarn "utilities as they have been shown to cause maya to crash."
	ewarn
	ewarn "You need to have a linuxthreads (without tls) glibc installed to"
	ewarn "use this package.  In otherwords, you need to NOT have linuxthreads-tls"
	ewarn "or nptlonly in your USE flags when you emerge glibc.  If you use nptl,"
	ewarn "you'll need to start maya with 'LD_ASSUME_KERNEL=2.4.1 maya'"
}
