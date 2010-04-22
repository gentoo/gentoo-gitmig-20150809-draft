# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-server/vmware-server-2.0.2.203138-r1.ebuild,v 1.1 2010/04/22 18:51:51 vadimk Exp $

# Unlike many other binary packages the user doesn't need to agree to a licence
# to download VMWare. The agreeing to a licence is part of the configure step
# which the user must run manually.

EAPI="2"

inherit eutils pam pax-utils versionator

MY_PV=$(replace_version_separator 3 '-' )
MY_PN="VMware-server-${MY_PV}"

DESCRIPTION="VMware Server for Linux"
HOMEPAGE="http://www.vmware.com/"
DOWNLOAD_URL="http://downloads.vmware.com/d/info/datacenter_downloads/vmware_server/2_0"
SRC_URI=" x86? ( mirror://vmware/software/vmserver/${MY_PN}.i386.tar.gz )
	  amd64? ( mirror://vmware/software/vmserver/${MY_PN}.x86_64.tar.gz ) "

LICENSE="vmware"
IUSE=""
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
RESTRICT="fetch strip"

CDEPEND="
	>=dev-lang/perl-5
	>=sys-libs/glibc-2.3.5
	sys-apps/pciutils"
DEPEND="${CDEPEND}
	sys-apps/findutils
	x11-misc/shared-mime-info
	virtual/os-headers"
# vmware-server should not use virtual/libc as this is a
# precompiled binary package thats linked to glibc.
RDEPEND="${CDEPEND}
	~app-emulation/vmware-modules-1.0.0.24
	dev-libs/expat
	dev-libs/glib
	dev-libs/libxml2
	sys-apps/hal
	sys-fs/fuse
	sys-libs/zlib
	virtual/pam
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXt
	x11-libs/libXtst
	x11-misc/xdg-utils
	!<sys-apps/dbus-0.62
	!app-emulation/vmware-player
	!app-emulation/vmware-workstation
	"

PDEPEND="app-emulation/vmware-vix"

S=${WORKDIR}/vmware-server-distrib

pkg_setup() {
	if use x86; then
		MY_P="${MY_PN}.i386"
	elif use amd64; then
		MY_P="${MY_PN}.x86_64"
	fi
}

pkg_nofetch() {
	if use x86; then
		MY_P="${MY_PN}.i386"
	elif use amd64; then
		MY_P="${MY_PN}.x86_64"
	fi

	einfo "Please download the ${MY_P}.bundle from"
	einfo "${DOWNLOAD_URL}"
	einfo "and place it in ${DISTDIR}"
}

src_prepare() {
	VMWARE_GROUP=${VMWARE_GROUP:-vmware}
	VMWARE_INSTALL_DIR=/opt/${PN//-//}

	shortname="wgs"
	product="vmware"
	config_program="vmware-config.pl"
	config_dir="/etc/vmware"
	product_name="VMware Server 2"

	enewgroup ${VMWARE_GROUP}

	# Remove PAX MPROTECT flag from all applicable files in /bin, /sbin for
	# the vmware package only (since modules, tools and console should not
	# need to generate code on the fly in memory).
	pax-mark -m $(list-paxables "${S}"/{bin{,-debug},sbin}/{vmware-serverd,vmware-vmx})

	EPATCH_SOURCE="${FILESDIR}"/${PV} EPATCH_SUFFIX="patch" epatch

	# Proper lsmod
	sed -i -e "s:/sbin/lsmod:/bin/lsmod:" "${S}"/installer/services.sh || die "sed"
	sed -i -e "s:/sbin/lsmod:/bin/lsmod:" "${S}"/lib/net-services.sh || die "sed"

	# Set the name
	sed -i -e "s:%LONGNAME%:${product_name}:" "${S}"/installer/services.sh || die "sed"
	sed -i -e "s:%SHORTNAME%:${shortname}:" "${S}"/installer/services.sh || die "sed"

	# We won't want any perl scripts from VMware once we've finally got all
	# of the configuration done, but for now, they're necessary.
	#rm -f *.pl bin/*.pl
	rm -f *.pl
	rm -f etc/installer.sh

	# Since with Gentoo we compile everthing it doesn't make sense to keep
	# the precompiled modules arround. Saves about 4 megs of disk space too.
	rm -rf "${S}"/lib/modules/binary
	# We also don't need to keep the icons around, or do we?
	#rm -rf ${S}/lib/share/icons

	rm -rf "${S}"/etc/pam.d/
	sed -i -e "s:configure_wgs_pam_d():#&:" "${S}"/bin/vmware-config.pl || die "sed pam_d"
}

src_install() {
	# We loop through our directories and copy everything to our system.
	for x in bin lib sbin
	do
		if [[ -e "${S}/${x}" ]]
		then
			dodir "${VMWARE_INSTALL_DIR}"/${x}
			cp -pPR "${S}"/${x}/* "${D}""${VMWARE_INSTALL_DIR}"/${x} \
				|| die "copying ${x}"
		fi
	done

	# Bug 282213
	mv "${D}"/"${VMWARE_INSTALL_DIR}"/lib/lib/libpng12.so.0/libpng12.so.0 \
	   "${D}"/"${VMWARE_INSTALL_DIR}"/lib/lib/libpng12.so.0/libpng12.so.0.old
	dosym /usr/lib/libpng12.so.0 "${VMWARE_INSTALL_DIR}"/lib/lib/libpng12.so.0/libpng12.so.0

	# Bug 292771
	mv "${D}"/"${VMWARE_INSTALL_DIR}"/lib/lib/libexpat.so.0/libexpat.so.0 \
	   "${D}"/"${VMWARE_INSTALL_DIR}"/lib/lib/libexpat.so.0/libexpat.so.0.old
	dosym /usr/lib/libexpat.so.1 "${VMWARE_INSTALL_DIR}"/lib/lib/libexpat.so.0/libexpat.so.0
	mv "${D}"/"${VMWARE_INSTALL_DIR}"/lib/lib/libxml2.so.2/libxml2.so.2 \
	   "${D}"/"${VMWARE_INSTALL_DIR}"/lib/lib/libxml2.so.2/libxml2.so.2.old
	dosym /usr/lib/libxml2.so.2 "${VMWARE_INSTALL_DIR}"/lib/lib/libxml2.so.2/libxml2.so.2

	# If we have an /etc directory, we copy it.
	if [[ -e "${S}/etc" ]]
	then
		dodir "${config_dir}"
		cp -pPR "${S}"/etc/* "${D}""${config_dir}"
		fowners root:${VMWARE_GROUP} "${config_dir}"
		fperms 770 "${config_dir}"
	fi

	# If we have any helper files, we install them.  First, we check for an
	# init script.
	if [[ -e "${FILESDIR}/${PN}.rc" ]]
	then
		newinitd "${FILESDIR}"/${PN}.rc ${product} || die "newinitd"
	fi
	# Then we check for an environment file.
	if [[ -e "${FILESDIR}/90${PN}" ]]
	then
		doenvd "${FILESDIR}"/90${PN} || die "doenvd"
	fi
	# Last, we check for any mime files.
	if [[ -e "${FILESDIR}/${PN}.xml" ]]
	then
		insinto /usr/share/mime/packages
		doins "${FILESDIR}"/${PN}.xml || die "mimetypes"
	fi

	# Blame bug #91191 for this one.
	if [[ -e doc/EULA ]]
	then
		insinto "${VMWARE_INSTALL_DIR}"/doc
		doins doc/EULA || die "copying EULA"
	fi

	# Do we have vmware-ping/vmware-vmx?  If so, make them setuid.
	for p in /bin/vmware-ping /lib/bin/vmware-vmx /lib/bin-debug/vmware-vmx /lib/bin/vmware-vmx-debug /sbin/vmware-authd;
	do
		if [ -x "${D}${VMWARE_INSTALL_DIR}${p}" ]
		then
			fowners root:${VMWARE_GROUP} "${VMWARE_INSTALL_DIR}"${p}
			fperms 4750 "${VMWARE_INSTALL_DIR}"${p}
		fi
	done

	# This removed the user/group warnings
	# But also broke vmware-server with FEATURES="userpriv" since it removes
	# the set-UID bit
	#chown -R root:${VMWARE_GROUP} ${D} || die

	# We like desktop icons.
	# TODO: Fix up the icon creation, across the board.
	#make_desktop_entry ${PN} "${product_name}" ${PN}.png

	# Now, we copy in our services.sh file
	exeinto "${config_dir}"/init.d
	newexe installer/services.sh ${product} || die "services.sh"

	newinitd "${FILESDIR}/vmware-server-2.rc" vmware

	# startup symlinks
	dosym ${config_dir}/init.d/${product} ${config_dir}/init.d/vmware-autostart
	dosym ${config_dir}/init.d/${product} ${config_dir}/init.d/vmware-core
	dosym ${config_dir}/init.d/${product} ${config_dir}/init.d/vmware-mgmt

	# pam
	pamd_mimic_system vmware-authd auth account

	# Man pages and docs
	dodoc doc/*
	doman man/man1/*

	# VMware authorization service
	insinto ${config_dir}/hostd
	doins "${FILESDIR}/authorization.xml"

	# Finally, we run the "Questions"
	einfo "Adding answers to ${config_dir}/locations"
	locations="${D}${config_dir}/locations"
	echo "answer BINDIR ${VMWARE_INSTALL_DIR}/bin" >> ${locations}
	echo "answer LIBDIR ${VMWARE_INSTALL_DIR}/lib" >> ${locations}
	echo "answer MANDIR ${VMWARE_INSTALL_DIR}/man" >> ${locations}
	echo "answer DOCDIR ${VMWARE_INSTALL_DIR}/doc" >> ${locations}
	echo "answer SBINDIR ${VMWARE_INSTALL_DIR}/sbin" >> ${locations}
	echo "answer RUN_CONFIGURATOR no" >> ${locations}
	echo "answer INITDIR ${config_dir}/init.d" >> ${locations}
	echo "answer INITSCRIPTSDIR ${config_dir}/init.d" >> ${locations}
	echo "answer VMCI_CONFED yes" >> ${locations}
	echo "answer VSOCK_CONFED yes" >> ${locations}
}

pkg_config() {
	einfo "Running ${VMWARE_INSTALL_DIR}/bin/vmware-config.pl"
	"${VMWARE_INSTALL_DIR}/bin/vmware-config.pl"
}

pkg_preinst() {
	# This must be done after the install to get the mtimes on each file
	# right.

	#Note: it's a bit weird to use ${D} in a preinst script but it should work
	#(drobbins, 1 Feb 2002)

	einfo "Generating ${config_dir}/locations file."
	d=`echo ${D} | wc -c`
	for x in `find ${D}${VMWARE_INSTALL_DIR} ${D}${config_dir}` ; do
		x="`echo ${x} | cut -c ${d}-`"
		if [ -d "${D}/${x}" ] ; then
			echo "directory ${x}" >> "${D}${config_dir}"/locations
		else
			echo -n "file ${x}" >> "${D}${config_dir}"/locations
			if [ "${x}" == "${config_dir}/locations" ] ; then
				echo "" >> "${D}${config_dir}"/locations
			elif [ "${x}" == "${config_dir}/not_configured" ] ; then
				echo "" >> "${D}${config_dir}"/locations
			else
				echo -n " " >> "${D}${config_dir}"/locations
				find "${D}${x}" -printf %T@ >> "${D}${config_dir}"/locations
				echo "" >> "${D}${config_dir}"/locations
			fi
		fi
	done
}

pkg_postinst() {
	update-mime-database /usr/share/mime
	[[ -d "${config_dir}" ]] && chown -R root:${VMWARE_GROUP} ${config_dir}

	# This is to fix the problem where the not_configured file doesn't get
	# removed when the configuration is run. This doesn't remove the file
	# It just tells the vmware-config.pl script it can delete it.
	einfo "Updating ${config_dir}/locations"
	for x in "${config_dir}"/._cfg????_locations ; do
		if [ -f $x ] ; then
			cat $x >> "${config_dir}"/locations
			rm $x
		fi
	done

	ewarn "Use "
	ewarn "  emerge vmware-server --config"
	ewarn "to configure your installation of ${product_name}."

	ewarn "In order to run ${product_name}, you have to"
	ewarn "be in the '${VMWARE_GROUP}' group."

	#ewarn "By default xinetd only allows connections from localhost"
	#ewarn "To allow external users access to vmware-server you must edit"
	#ewarn "    /etc/xinetd.d/vmware-authd"
	#ewarn "and specify a new 'only_from' line"

	ewarn "VMWare Server also has issues when running on a JFS filesystem.  For more"
	ewarn "information see http://bugs.gentoo.org/show_bug.cgi?id=122500#c94"
}

pkg_prerm() {
	einfo "Stopping ${product_name} for safe unmerge"
	/etc/init.d/vmware stop
}

pkg_postrm() {
	if ! has_version app-emulation/${PN}; then
		elog "To remove all traces of ${product} you will need to remove the files"
		elog "in ${config_dir} and /etc/init.d/${product}."
		elog "If the vmware-modules package is installed, you may no longer need it."
	fi
}
