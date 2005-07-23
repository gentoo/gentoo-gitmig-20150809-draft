# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/vdr-plugin.eclass,v 1.1 2005/07/23 15:11:25 zzam Exp $
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


inherit eutils flag-o-matic

# Name of the plugin stripped from all vdrplugin-, vdr- and -cvs pre- and postfixes
VDRPLUGIN="${PN/#vdrplugin-/}"
VDRPLUGIN="${PN/#vdr-/}"
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

# Pathes to includes
VDR_INCLUDE_DIR="/usr/include"
DVB_INCLUDE_DIR="/usr/include"

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
}

vdr-plugin_pkg_postinst() {
	einfo
	einfo "The vdr plugin ${VDRPLUGIN} has now been installed,"
	einfo "to activate it you have to add it to /etc/conf.d/vdr."
	einfo
}

EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_install pkg_postinst
