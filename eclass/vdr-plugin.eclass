# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/vdr-plugin.eclass,v 1.18 2006/04/26 12:57:05 zzam Exp $
#
# Author:
#   Matthias Schwarzott <zzam@gentoo.org>

# vdr-plugin.eclass
#
#   eclass to create ebuilds for vdr plugins
#

# Example ebuild (vdr-femon):
#
#	inherit vdr-plugin
#	IUSE=""
#	SLOT="0"
#	DESCRIPTION="vdr Plugin: DVB Frontend Status Monitor (signal strengt/noise)"
#	HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/femon/"
#	SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/femon/files/${P}.tgz"
#	LICENSE="GPL-2"
#	KEYWORDS="~x86"
#	DEPEND=">=media-video/vdr-1.3.27"
#
#

# Installation of a config file for the plugin
#
#     If ${VDR_CONFD_FILE} is set install this file
#     else install ${FILESDIR}/confd if it exists.

#     Gets installed as /etc/conf.d/vdr.${VDRPLUGIN}.
#     For the plugin vdr-femon this would be /etc/conf.d/vdr.femon


# Installation of an rc-addon file for the plugin
#
#     If ${VDR_RCADDON_FILE} is set install this file
#     else install ${FILESDIR}/rc-addon.sh if it exists.
#
#     Gets installed under /usr/lib/vdr/rcscript/plugin-${VDRPLUGIN}.sh
#     (in example vdr-femon this would be /usr/lib/vdr/rcscript/plugin-femon.sh)
#
#     This file is sourced by the startscript when plugin is activated in /etc/conf.d/vdr
#     It could be used for special startup actions for this plugins, or to create the
#     plugin command line options from a nicer version of a conf.d file.

inherit base eutils flag-o-matic

IUSE="debug"

# Name of the plugin stripped from all vdrplugin-, vdr- and -cvs pre- and postfixes
VDRPLUGIN="${PN/#vdrplugin-/}"
VDRPLUGIN="${VDRPLUGIN/#vdr-/}"
VDRPLUGIN="${VDRPLUGIN/%-cvs/}"

DESCRIPTION="vdr Plugin: ${VDRPLUGIN} (based on vdr-plugin.eclass)"

# works in most cases
S="${WORKDIR}/${VDRPLUGIN}-${PV}"

# depend on headers for DVB-driver
RDEPEND=""
DEPEND="media-tv/linuxtv-dvb-headers"

# Where should the plugins live in the filesystem
VDR_PLUGIN_DIR="/usr/lib/vdr/plugins"

VDR_RC_DIR="/usr/lib/vdr/rcscript"

# Pathes to includes
VDR_INCLUDE_DIR="/usr/include"
DVB_INCLUDE_DIR="/usr/include"


# this code is from linux-mod.eclass
update_vdrplugindb() {
	local VDRPLUGINDB_DIR=${ROOT}/var/lib/vdrplugin-rebuild/

	if [[ ! -f ${VDRPLUGINDB_DIR}/vdrplugindb ]]; then
		[[ ! -d ${VDRPLUGINDB_DIR} ]] && mkdir -p ${VDRPLUGINDB_DIR}
		touch ${VDRPLUGINDB_DIR}/vdrplugindb
	fi
	if [[ -z $(grep ${CATEGORY}/${PN}-${PVR} ${VDRPLUGINDB_DIR}/vdrplugindb) ]]; then
		einfo "Adding plugin to vdrplugindb."
		echo "a:1:${CATEGORY}/${PN}-${PVR}" >> ${VDRPLUGINDB_DIR}/vdrplugindb
	fi
}

remove_vdrplugindb() {
	local VDRPLUGINDB_DIR=${ROOT}/var/lib/vdrplugin-rebuild/

	if [[ -n $(grep ${CATEGORY}/${PN}-${PVR} ${VDRPLUGINDB_DIR}/vdrplugindb) ]]; then
		einfo "Removing ${CATEGORY}/${PN}-${PVR} from vdrplugindb."
		sed -ie "/.*${CATEGORY}\/${P}.*/d" ${VDRPLUGINDB_DIR}/vdrplugindb
	fi
}

vdr-plugin_pkg_setup() {
	# -fPIC is needed for shared objects on some platforms (amd64 and others)
	append-flags -fPIC
	use debug && append-flags -g

	VDRVERSION=$(awk -F'"' '/VDRVERSION/ {print $2}' /usr/include/vdr/config.h)
	APIVERSION=$(awk -F'"' '/APIVERSION/ {print $2}' /usr/include/vdr/config.h)
	[[ -z ${APIVERSION} ]] && APIVERSION="${VDRVERSION}"

	einfo "Building ${PF} against vdr-${VDRVERSION}"
	einfo "APIVERSION: ${APIVERSION}"
}

vdr-plugin_src_unpack() {
	[ -z "$1" ] && vdr-plugin_src_unpack unpack patchmakefile

	while [ "$1" ]; do

		case "$1" in
		unpack)
			base_src_unpack
			;;
		patchmakefile)
			cd ${S}

			ebegin "Patching Makefile"
			sed -i.orig Makefile \
				-e "s:^VDRDIR.*$:VDRDIR = ${VDR_INCLUDE_DIR}:" \
				-e "s:^DVBDIR.*$:DVBDIR = ${DVB_INCLUDE_DIR}:" \
				-e "s:^LIBDIR.*$:LIBDIR = ${S}:" \
				-e "s:^TMPDIR.*$:TMPDIR = ${T}:" \
				-e 's:^CXXFLAGS:#CXXFLAGS:' \
				-e 's:-I$(VDRDIR)/include:-I$(VDRDIR):' \
				-e 's:-I$(DVBDIR)/include:-I$(DVBDIR):' \
				-e 's:-I$(VDRDIR) -I$(DVBDIR):-I$(DVBDIR) -I$(VDRDIR):' \
				-e 's:$(VDRDIR)/\([a-z]*\.h\|Make.config\):$(VDRDIR)/vdr/\1:' \
				-e 's:^APIVERSION = :APIVERSION ?= :' \
				-e 's:$(LIBDIR)/$@.$(VDRVERSION):$(LIBDIR)/$@.$(APIVERSION):' \
				-e '1i\APIVERSION = '"${APIVERSION}"
			eend $?
			;;
		esac

		shift
	done
}

vdr-plugin_copy_source_tree() {
	cp -r ${S} ${T}/source-tree
	cd ${T}/source-tree
	mv Makefile.orig Makefile
	sed -i Makefile \
		-e "s:^DVBDIR.*$:DVBDIR = ${DVB_INCLUDE_DIR}:" \
		-e 's:^CXXFLAGS:#CXXFLAGS:' \
		-e 's:-I$(DVBDIR)/include:-I$(DVBDIR):' \
		-e 's:-I$(VDRDIR) -I$(DVBDIR):-I$(DVBDIR) -I$(VDRDIR):'
}

vdr-plugin_install_source_tree() {
	einfo "Installing sources"
	destdir=${VDRSOURCE_DIR}/vdr-${VDRVERSION}/PLUGINS/src/${VDRPLUGIN}
	insinto ${destdir}-${PV}
	doins -r ${T}/source-tree/*

	dosym ${VDRPLUGIN}-${PV} ${destdir}
}

vdr-plugin_src_compile() {
	[ -z "$1" ] && vdr-plugin_src_compile prepare compile

	while [ "$1" ]; do

		case "$1" in
		prepare)
			[[ -n "${VDRSOURCE_DIR}" ]] && vdr-plugin_copy_source_tree
			;;
		compile)
			cd ${S}

			emake ${VDRPLUGIN_MAKE_TARGET:-all} || die "emake failed"
			;;
		esac

		shift
	done
}

vdr-plugin_src_install() {
	[[ -n "${VDRSOURCE_DIR}" ]] && vdr-plugin_install_source_tree
	cd ${S}

	insinto "${VDR_PLUGIN_DIR}"
	doins libvdr-*.so.*
	dodoc README* HISTORY CHANGELOG


	# if VDR_CONFD_FILE is empty and ${FILESDIR}/confd exists take it
	[[ -z ${VDR_CONFD_FILE} ]] && [[ -e ${FILESDIR}/confd ]] && VDR_CONFD_FILE=${FILESDIR}/confd

	if [[ -n ${VDR_CONFD_FILE} ]]; then
		insinto /etc/conf.d
		newins "${VDR_CONFD_FILE}" vdr.${VDRPLUGIN}
	fi


	# if VDR_RCADDON_FILE is empty and ${FILESDIR}/rc-addon.sh exists take it
	[[ -z ${VDR_RCADDON_FILE} ]] && [[ -e ${FILESDIR}/rc-addon.sh ]] && VDR_RCADDON_FILE=${FILESDIR}/rc-addon.sh

	if [[ -n ${VDR_RCADDON_FILE} ]]; then
		insinto "${VDR_RC_DIR}"
		newins "${VDR_RCADDON_FILE}" plugin-${VDRPLUGIN}.sh
	fi



	insinto /usr/lib/vdr/checksums
	if [[ -f ${ROOT}/usr/lib/vdr/checksums/header-md5-vdr ]]; then
		newins ${ROOT}/usr/lib/vdr/checksums/header-md5-vdr header-md5-${PN}
	else
		if which md5sum >/dev/null 2>&1; then
			cd ${S}
			(
				cd ${ROOT}${VDR_INCLUDE_DIR}/vdr
				md5sum *.h libsi/*.h|LC_ALL=C sort --key=2
			) > header-md5-${PN}
			doins header-md5-${PN}
		fi
	fi
}

vdr-plugin_pkg_postinst() {
	update_vdrplugindb
	einfo
	einfo "The vdr plugin ${VDRPLUGIN} has now been installed."
	einfo "To activate execute the following command:"
	einfo
	einfo "  emerge --config ${PN}"
	einfo
	if [[ -n "${VDR_CONFD_FILE}" ]]; then
		einfo "And have a look at the config-file"
		einfo "/etc/conf.d/vdr.${VDRPLUGIN}"
		einfo
	fi
}

vdr-plugin_pkg_postrm() {
	remove_vdrplugindb
}

vdr-plugin_pkg_config_final() {
	diff ${conf_orig} ${conf}
	rm ${conf_orig}
}

vdr-plugin_pkg_config() {
	if [[ -z "${INSTALLPLUGIN}" ]]; then
		INSTALLPLUGIN="${VDRPLUGIN}"
	fi
	# First test if plugin is already inside PLUGINS
	local conf=/etc/conf.d/vdr
	conf_orig=${conf}.before_emerge_config
	cp ${conf} ${conf_orig}

	einfo "Reading ${conf}"
	if ! grep -q "^PLUGINS=" ${conf}; then
		local LINE=$(sed ${conf} -n -e '/^#.*PLUGINS=/=' | tail -n 1)
		if [[ -n "${LINE}" ]]; then
			sed -e ${LINE}'a PLUGINS=""' -i ${conf}
		else
			echo 'PLUGINS=""' >> ${conf}
		fi
		unset LINE
	fi

	unset PLUGINS
	PLUGINS=$(source /etc/conf.d/vdr; echo ${PLUGINS})

	active=0
	for p in ${PLUGINS}; do
		if [[ "${p}" == "${INSTALLPLUGIN}" ]]; then
			active=1
			break;
		fi
	done

	if [[ "${active}" == "1" ]]; then
		einfo "${INSTALLPLUGIN} already activated"
		echo
		read -p "Do you want to deactivate ${INSTALLPLUGIN} (yes/no) " answer
		if [[ "${answer}" != "yes" ]]; then
			einfo "aborted"
			return
		fi
		einfo "Removing ${INSTALLPLUGIN} from active plugins."
		local LINE=$(sed ${conf} -n -e '/^PLUGINS=.*\<'${INSTALLPLUGIN}'\>/=' | tail -n 1)
		sed -i ${conf} -e ${LINE}'s/\<'${INSTALLPLUGIN}'\>//' \
			-e ${LINE}'s/ \( \)*/ /g' \
			-e ${LINE}'s/ "/"/g' \
			-e ${LINE}'s/" /"/g'

		vdr-plugin_pkg_config_final
		return
	fi


	einfo "Adding ${INSTALLPLUGIN} to active plugins."
	local LINE=$(sed ${conf} -n -e '/^PLUGINS=/=' | tail -n 1)
	sed -i ${conf} -e ${LINE}'s/^PLUGINS=" *\(.*\)"/PLUGINS="\1 '${INSTALLPLUGIN}'"/' \
		-e ${LINE}'s/ \( \)*/ /g' \
		-e ${LINE}'s/ "/"/g' \
		-e ${LINE}'s/" /"/g'

	vdr-plugin_pkg_config_final
}

EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_install pkg_postinst pkg_postrm pkg_config
