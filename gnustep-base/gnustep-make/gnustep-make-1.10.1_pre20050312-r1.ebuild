# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-make/gnustep-make-1.10.1_pre20050312-r1.ebuild,v 1.1 2005/03/22 22:53:11 fafhrd Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="savannah.gnu.org:/cvsroot/gnustep"
ECVS_USER="anoncvs"
ECVS_AUTH="ext"
ECVS_MODULE="gnustep/core/make"
ECVS_CO_OPTS="-P -D ${PV/*_pre}"
ECVS_UP_OPTS="-dP -D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/savannah.gnu.org-gnustep"
inherit gnustep cvs

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="The makefile package is a simple, powerful and extensible way to write makefiles for a GNUstep-based project."
HOMEPAGE="http://www.gnustep.org"

KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~alpha"
SLOT="0"
LICENSE="GPL-2"

IUSE="${IUSE} doc layout-from-conf-file layout-osx-like non-flattened"
DEPEND="${GNUSTEP_CORE_DEPEND}
	>=sys-devel/make-3.75
	${DOC_DEPEND}"
RDEPEND="${DEPEND}
	${DOC_RDEPEND}"

egnustep_install_domain "System"

pkg_setup() {
	gnustep_pkg_setup

	if [ "$(objc_available)" == "no" ]; then
		objc_not_available_info
		die "ObjC support not available"
	fi

	if use layout-from-conf-file && use layout-osx-like ; then
		eerror "layout-from-conf-file and layout-osx-like are mutually exclusive use flags."
		die "USE flag misconfiguration -- please correct"
	fi

	if use layout-from-conf-file || use layout-osx-like ; then
		ewarn "USE layout-from-conf-file || layout-osx-like"
		ewarn "Utilizing these USE flags allows one to install files in non standard"
		ewarn "  locations vis a vis the Linux FHS -- please fully comprehend what you"
		ewarn "  are doing when setting this USE flag."
	fi

	if use layout-from-conf-file; then
		if [ ! -f /etc/conf.d/gnustep.env ]; then
			eerror "There is no /etc/conf.d/gnustep.env file!"
			eerror "Did you read the USE flag description?"
			die "USE flag misconfiguration -- please correct"
		else
			unset GNUSTEP_SYSTEM_ROOT
			unset GNUSTEP_LOCAL_ROOT
			unset GNUSTEP_NETWORK_ROOT
			unset GNUSTEP_USER_ROOT
			. /etc/conf.d/gnustep.env
			if [ -z "${GNUSTEP_SYSTEM_ROOT}" ] || [ "/" != "${GNUSTEP_SYSTEM_ROOT:0:1}" ]; then
				eerror "GNUSTEP_SYSTEM_ROOT is missing or misconfigured in /etc/conf.d/gnustep.env"
				eerror "GNUSTEP_SYSTEM_ROOT=${GNUSTEP_SYSTEM_ROOT}"
				die "USE flag misconfiguration -- please correct"
			fi
			if [ "/System" != ${GNUSTEP_SYSTEM_ROOT:$((${#GNUSTEP_SYSTEM_ROOT}-7)):7} ]; then
				eerror "GNUSTEP_SYSTEM_ROOT must end with \"System\" -- read the USE flag directions!!!"
				die "USE flag misconfiguration -- please correct"
			fi
			if [ "${GNUSTEP_LOCAL_ROOT}" ] && [ "/" != "${GNUSTEP_LOCAL_ROOT:0:1}" ]; then
				eerror "GNUSTEP_LOCAL_ROOT is misconfigured in /etc/conf.d/gnustep.env"
				eerror "GNUSTEP_LOCAL_ROOT=${GNUSTEP_LOCAL_ROOT}"
				die "USE flag misconfiguration -- please correct"
			elif [ -z "${GNUSTEP_LOCAL_ROOT}" ]; then
				GNUSTEP_LOCAL_ROOT="$(dirname ${GNUSTEP_SYSTEM_ROOT})/Local"
			fi
			if [ "${GNUSTEP_NETWORK_ROOT}" ] && [ "/" != "${GNUSTEP_NETWORK_ROOT:0:1}" ]; then
				eerror "GNUSTEP_NETWORK_ROOT is misconfigured in /etc/conf.d/gnustep.env"
				eerror "GNUSTEP_NETWORK_ROOT=${GNUSTEP_NETWORK_ROOT}"
				die "USE flag misconfiguration -- please correct"
			elif [ -z "${GNUSTEP_NETWORK_ROOT}" ]; then
				GNUSTEP_NETWORK_ROOT="$(dirname ${GNUSTEP_SYSTEM_ROOT})/Network"
			fi
			if [ "${GNUSTEP_USER_ROOT}" ] && [ '~' != "${GNUSTEP_USER_ROOT:0:1}" ]; then
				eerror "GNUSTEP_USER_ROOT is misconfigured in /etc/conf.d/gnustep.env"
				eerror "GNUSTEP_USER_ROOT=${GNUSTEP_USER_ROOT}"
				die "USE flag misconfiguration -- please correct"
			elif [ -z "${GNUSTEP_USER_ROOT}" ]; then
				GNUSTEP_USER_ROOT='~/GNUstep'
			fi

			egnustep_prefix "$(dirname ${GNUSTEP_SYSTEM_ROOT})"
			egnustep_system_root "${GNUSTEP_SYSTEM_ROOT}"
			egnustep_local_root "${GNUSTEP_LOCAL_ROOT}"
			egnustep_network_root "${GNUSTEP_NETWORK_ROOT}"
			egnustep_user_root "${GNUSTEP_USER_ROOT}"
		fi
	elif use layout-osx-like; then
		egnustep_prefix "/"
		egnustep_system_root "/System"
		egnustep_local_root "/"
		egnustep_network_root "/Network"
		egnustep_user_root '~'
	else
		# setup defaults here
		egnustep_prefix "/usr/GNUstep"
		egnustep_system_root "/usr/GNUstep/System"
		egnustep_local_root "/usr/GNUstep/Local"
		egnustep_network_root "/usr/GNUstep/Network"
		egnustep_user_root '~/GNUstep'
	fi

	einfo "GNUstep installation will be laid out thusly:"
	einfo "\tGNUSTEP_SYSTEM_ROOT=`egnustep_system_root`"
	einfo "\tGNUSTEP_LOCAL_ROOT=`egnustep_local_root`"
	einfo "\tGNUSTEP_NETWORK_ROOT=`egnustep_network_root`"
	einfo "\tGNUSTEP_USER_ROOT=`egnustep_user_root`"
	ebeep
	epause 10
}

src_unpack() {
	cvs_src_unpack
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/make-user-defaults.patch-1.10.0
}

src_compile() {
	cd ${S}

	# gnustep-make ./configure : "prefix" here is going to be where
	#  "System" is installed -- other correct paths should be set
	#  by econf
	local myconf
	myconf="--prefix=`egnustep_prefix`"
	use non-flattened && myconf="$myconf --disable-flattened"
	myconf="$myconf --with-tar=/bin/tar"
	myconf="$myconf --with-local-root=`egnustep_local_root`"
	myconf="$myconf --with-network-root=`egnustep_network_root`"
	myconf="$myconf --with-user-root=`egnustep_user_root`"
	econf $myconf || die "configure failed"

	egnustep_make
}

src_install() {
	. ${S}/GNUstep.sh

	if [ -f ./[mM]akefile -o -f ./GNUmakefile ] ; then
		local make_eval="INSTALL_ROOT=\${D} \
		GNUSTEP_SYSTEM_ROOT=\${D}\$(egnustep_system_root) \
		GNUSTEP_NETWORK_ROOT=\${D}\$(egnustep_network_root) \
		GNUSTEP_LOCAL_ROOT=\${D}\$(egnustep_local_root) \
		GNUSTEP_MAKEFILES=\${D}\$(egnustep_system_root)/Library/Makefiles \
		GNUSTEP_USER_ROOT=\${TMP} \
		GNUSTEP_DEFAULTS_ROOT=\${TMP}/\${__GS_USER_ROOT_POSTFIX} \
		-j1"

		if use debug ; then
			make_eval="${make_eval} debug=yes"
		fi
		if use verbose ; then
			make_eval="${make_eval} verbose=yes"
		fi
		eval emake ${make_eval} install || die "install has failed"
	else
		die "no Makefile found"
	fi

	if use doc ; then
		cd Documentation
		eval emake ${make_eval} all || die "doc make has failed"
		eval emake ${make_eval} install || die "doc install has failed"
		cd ..
	fi

	dodir /etc/conf.d
	echo "GNUSTEP_SYSTEM_ROOT=$(egnustep_system_root)" > ${D}/etc/conf.d/gnustep.env
	echo "GNUSTEP_LOCAL_ROOT=$(egnustep_local_root)" >> ${D}/etc/conf.d/gnustep.env
	echo "GNUSTEP_NETWORK_ROOT=$(egnustep_network_root)" >> ${D}/etc/conf.d/gnustep.env
	echo "GNUSTEP_USER_ROOT='$(egnustep_user_root)'" >> ${D}/etc/conf.d/gnustep.env
}

