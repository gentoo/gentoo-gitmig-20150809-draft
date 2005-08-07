# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/vdr-plugin.eclass,v 1.2 2005/08/07 13:55:43 zzam Exp $
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

# There are some special files in ${FILESDIR} which get installed when
# they exist:

# ${FILESDIR}/confd-${PV} or ${FILESDIR}/confd:
#     The first matching is installed under /etc/conf.d/vdr.${VDRPLUGIN}
#       (in example vdr-femon this would be /etc/conf.d/vdr.femon)
#
#     Everything put in variable _EXTRAOPTS is appended to the command line of
#     the plugin.


# ${FILESDIR}/rc-addon-${PV}.sh or ${FILESDIR}/rc-addon.sh:
#     The first matching is installed under /usr/lib/vdr/rcscript/vdr.${VDRPLUGIN}.sh
#     (in example vdr-femon this would be /usr/lib/vdr/rcscript/vdr.femon.sh)
#
#     This file is sourced by the startscript when plugin is activated in /etc/conf.d/vdr
#     It could be used for special startup actions for this plugins, or to create the
#     plugin command line options from a nicer version of a conf.d file.

inherit eutils flag-o-matic

# Name of the plugin stripped from all vdrplugin-, vdr- and -cvs pre- and postfixes
VDRPLUGIN="${PN/#vdrplugin-/}"
VDRPLUGIN="${VDRPLUGIN/#vdr-/}"
VDRPLUGIN="${VDRPLUGIN/%-cvs/}"

DESCRIPTION="vdr Plugin: ${VDRPLUGIN} (based on vdr-plugin.eclass)"

# works in most cases
S="${WORKDIR}/${VDRPLUGIN}-${PV}"

# depend on headers for DVB-driver
RDEPEND=""
DEPEND="|| (
		>=sys-kernel/linux-headers-2.6.11-r2
		media-tv/linuxtv-dvb
	)"

# Where should the plugins live in the filesystem
VDR_PLUGIN_DIR="/usr/lib/vdr/plugins"

VDR_RC_DIR="/usr/lib/vdr/rcscript"

# Pathes to includes
VDR_INCLUDE_DIR="/usr/include"
DVB_INCLUDE_DIR="/usr/include"


# this code is from linux-mod.eclass
update_vdrplugindb() {
	local VDRPLUGINDB_DIR=${ROOT}/var/lib/vdrplugins-rebuild/

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
	local VDRPLUGINDB_DIR=${ROOT}/var/lib/vdrplugins-rebuild/

	if [[ -n $(grep ${CATEGORY}/${PN}-${PVR} ${VDRPLUGINDB_DIR}/vdrplugindb) ]]; then
		einfo "Removing ${CATEGORY}/${PN}-${PVR} from vdrplugindb."
		sed -ie "/.*${CATEGORY}\/${P}.*/d" ${VDRPLUGINDB_DIR}/vdrplugindb
	fi
}

vdr-plugin_pkg_setup() {
	# -fPIC is needed for shared objects on some platforms (amd64 and others)
	append-flags -fPIC

	VDRVERSION=$(awk -F'"' '/VDRVERSION/ {print $2}' /usr/include/vdr/config.h)
	einfo "Building ${PF} against vdr-${VDRVERSION}"
}

vdr-plugin_src_unpack() {
	[ -z "$1" ] && vdr-plugin_src_unpack unpack patchmakefile

	while [ "$1" ]; do

		case "$1" in
		unpack)
			unpack ${A}
			;;
		patchmakefile)
			cd ${S}

			ebegin "Patching Makefile"
			sed -i Makefile \
				-e "s:^VDRDIR.*$:VDRDIR = ${VDR_INCLUDE_DIR}:" \
				-e "s:^DVBDIR.*$:DVBDIR = ${DVB_INCLUDE_DIR}:" \
				-e "s:^LIBDIR.*$:LIBDIR = ${S}:" \
				-e "s:^TMPDIR.*$:TMPDIR = ${T}:" \
				-e 's:^CXXFLAGS:#CXXFLAGS:' \
				-e 's:-I$(VDRDIR)/include:-I$(VDRDIR):' \
				-e 's:-I$(DVBDIR)/include:-I$(DVBDIR):' \
				-e 's:-I$(VDRDIR) -I$(DVBDIR):-I$(DVBDIR) -I$(VDRDIR):' \
				-e 's:$(VDRDIR)/\(config.h\|Make.config\):$(VDRDIR)/vdr/\1:'
			eend $?
			;;
		esac

		shift
	done
}

vdr-plugin_src_compile() {
	cd ${S}

	emake ${VDRPLUGIN_MAKE_TARGET:-all} || die "emake failed"
}

vdr-plugin_src_install() {
	cd ${S}

	insinto "${VDR_PLUGIN_DIR}"
	doins libvdr-*.so.*
	dodoc README* HISTORY CHANGELOG

	for f in ${FILESDIR}/confd-${PV} ${FILESDIR}/confd; do
		if [[ -f "${f}" ]]; then
			insinto /etc/conf.d
			newins "${f}" vdr.${VDRPLUGIN}
			break
		fi
	done

	for f in ${FILESDIR}/rc-addon-${PV}.sh ${FILESDIR}/rc-addon.sh; do
		if [[ -f "${f}" ]]; then
			insinto "${VDR_RC_DIR}"
			newins "${f}" vdr.${VDRPLUGIN}.sh
			break
		fi
	done
}

vdr-plugin_pkg_postinst() {
	update_vdrplugindb
	einfo
	einfo "The vdr plugin ${VDRPLUGIN} has now been installed,"
	einfo "to activate it you have to add it to /etc/conf.d/vdr."
	einfo
}

vdr-plugin_pkg_postrm() {
	remove_vdrplugindb
}

EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_install pkg_postinst pkg_postrm
