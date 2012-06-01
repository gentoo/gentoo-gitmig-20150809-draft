# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-vix/vmware-vix-1.6.2.156745-r2.ebuild,v 1.3 2012/06/01 00:08:48 zmedico Exp $

# Unlike many other binary packages the user doesn't need to agree to a licence
# to download VMWare. The agreeing to a licence is part of the configure step
# which the user must run manually.

EAPI="2"

inherit eutils user versionator

MY_PV=$(replace_version_separator 3 '-' )
MY_PN="VMware-vix-${MY_PV}"

DESCRIPTION="VMware VIX for Linux"
HOMEPAGE="http://www.vmware.com/"
SRC_URI=" x86? ( mirror://vmware/software/vmserver/${MY_PN}.i386.tar.gz )
		amd64? ( mirror://vmware/software/vmserver/${MY_PN}.x86_64.tar.gz ) "

LICENSE="vmware"
IUSE=""
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
RESTRICT="strip"

# vmware-server should not use virtual/libc as this is a
# precompiled binary package thats linked to glibc.
DEPEND="
	>=dev-lang/perl-5
	sys-apps/pciutils
	sys-apps/findutils
	>=sys-libs/glibc-2.3.5
	x11-misc/shared-mime-info
	virtual/os-headers"
RDEPEND="${DEPEND}
	dev-libs/glib
	dev-libs/libxml2
	dev-libs/openssl
	net-misc/curl
	sys-libs/zlib
	!app-emulation/vmware-workstation
	"

S=${WORKDIR}/vmware-vix-distrib

pkg_setup() {
	if use x86; then
		MY_P="${MY_PN}.i386"
	elif use amd64; then
		MY_P="${MY_PN}.x86_64"
	fi
}

src_prepare() {
	VMWARE_GROUP=${VMWARE_GROUP:-vmware}
	VMWARE_INSTALL_DIR=/opt/${PN//-//}

	shortname="vix"
	product="vmware-vix"
	config_dir="/etc/vmware-vix"
	product_name="VMware VIX API"

	enewgroup ${VMWARE_GROUP}
#	EPATCH_SOURCE="${FILESDIR}"/${PV} EPATCH_SUFFIX="patch" epatch

	sed -i -e "s:/sbin/lsmod:/bin/lsmod:" "${S}"/installer/services.sh || die "sed of services"

	# We won't want any perl scripts from VMware
	rm -f *.pl bin/*.pl
	rm -f etc/installer.sh
}

src_install() {
	# We loop through our directories and copy everything to our system.
	for x in api bin lib include
	do
		if [[ -e "${S}/vmware-vix/${x}" ]]
		then
			dodir "${VMWARE_INSTALL_DIR}"/${x}
			cp -pPR "${S}"/vmware-vix/${x}/* "${D}""${VMWARE_INSTALL_DIR}"/${x} \
				|| die "copying ${x}"
		fi
	done

	# If we have an /etc directory, we copy it.
	#if [[ -e "${S}/etc" ]]
	#then
		dodir "${config_dir}"
	#	cp -pPR "${S}"/etc/* "${D}""${config_dir}"
	#	fowners root:${VMWARE_GROUP} "${config_dir}"
	#	fperms 770 "${config_dir}"
	#fi

	# If we have any helper files, we install them.  First, we check for an
	# init script.
	if [[ -e "${FILESDIR}/${PN}.rc" ]]
	then
		newinitd "${FILESDIR}"/${PN}.rc ${product} || die "newinitd"
	fi

	local ENVD="${T}/90${PN}"
	echo "PATH=${VMWARE_INSTALL_DIR}/bin" > "${ENVD}"
	echo "ROOTPATH=${VMWARE_INSTALL_DIR}/bin" >> "${ENVD}"
	doenvd "${ENVD}" || die "doenvd"

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

	# Now, we copy in our services.sh file
	#exeinto "${config_dir}"/init.d
	#newexe installer/services.sh ${product} || die "services.sh"

	dohtml -r doc/VMwareVix/*

	# Finally, we run the "questions"
	# Questions:
	einfo "Adding answers to ${config_dir}/locations"
	locations="${D}${config_dir}/locations"
	echo "answer BINDIR ${VMWARE_INSTALL_DIR}/bin" >> ${locations}
	echo "answer VIXLIBDIR ${VMWARE_INSTALL_DIR}/lib" >> ${locations}
	echo "answer LIBDIR ${VMWARE_INSTALL_DIR}/lib" >> ${locations}
	#echo "answer MANDIR ${VMWARE_INSTALL_DIR}/man" >> ${locations}
	echo "answer DOCDIR /usr/share/doc/${P}" >> ${locations}

	local VMWARECONFIG="${T}"/config
	if [[ -e ${ROOT}/etc/vmware/config ]]
	then
		cp -a "${ROOT}"/etc/vmware/config "${VMWARECONFIG}"
		sed -i -e "/vix.libdir/d" "${VMWARECONFIG}"
	fi
	echo "vix.libdir = \"${VMWARE_INSTALL_DIR}/lib\"" >> "${VMWARECONFIG}"
	insinto /etc/vmware/
	doins "${VMWARECONFIG}"
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

	ewarn "In order to run ${product_name}, you have to"
	ewarn "be in the '${VMWARE_GROUP}' group."
}

pkg_prerm() {
	sed -i -e "/vix.libdir/d" "${ROOT}"/etc/vmware/config
}

pkg_postrm() {
	if ! has_version app-emulation/${PN}; then
		ewarn "To remove all traces of ${producti_name} you will need to remove the files"
		ewarn "in ${config_dir} and /etc/init.d/${product}."
		ewarn "If the vmware-modules package is installed, you may no longer need it."
	fi
}
