# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/gentoo-vdr-scripts/gentoo-vdr-scripts-0.4.0.ebuild,v 1.1 2007/07/07 12:56:59 zzam Exp $

inherit eutils

DESCRIPTION="Scripts necessary for use of vdr as a set-top-box"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~zzam/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nvram"

RDEPEND="nvram? ( sys-power/nvram-wakeup )
	app-admin/sudo
	!<media-tv/vdr-dvd-scripts-0.0.2"

VDR_HOME=/var/vdr

pkg_setup() {
	enewgroup vdr

	# Add user vdr to these groups:
	#   video - accessing dvb-devices
	#   audio - playing sound when using software-devices
	#   cdrom - playing dvds/audio-cds ...
	enewuser vdr -1 /bin/bash "${VDR_HOME}" vdr,video,audio,cdrom
}

src_install() {
	local myopts=""
	if use nvram ; then
		myopts="${myopts} NVRAM=1"
	fi

	emake -s install DESTDIR="${D}" ${myopts} || die "make install failed"
	dodoc README TODO ChangeLog


	# create necessary directories
	diropts -ovdr -gvdr
	keepdir "${VDR_HOME}"

	local kd
	for kd in shutdown-data merged-config-files dvd-images tmp; do
		keepdir "${VDR_HOME}/${kd}"
	done
}

pkg_preinst() {
	einfo "Smart updating /etc/conf.d/vdr.plugins"
	local PLUGINS_NEW=0
	if [[ -f ${ROOT}/etc/conf.d/vdr.plugins ]]; then
		PLUGINS_NEW=$(grep -v '^#' ${ROOT}/etc/conf.d/vdr.plugins |grep -v '^$'|wc -l)
	fi
	if [[ ${PLUGINS_NEW} > 0 ]]; then
		einfo "Using existing /etc/conf.d/vdr.plugins"
		cp ${ROOT}/etc/conf.d/vdr.plugins ${D}/etc/conf.d/vdr.plugins
	else
		einfo "Using PLUGINS from /etc/conf.d/vdr"
		local PLUGIN
		for PLUGIN in $(source ${ROOT}/etc/conf.d/vdr;echo $PLUGINS); do
			echo ${PLUGIN} >> ${D}/etc/conf.d/vdr.plugins
		done
	fi
}

VDRSUDOENTRY="vdr ALL=NOPASSWD:/usr/share/vdr/bin/vdrshutdown-really.sh"

pkg_postinst() {
	if has_version "<media-tv/gentoo-vdr-scripts-0.3.6"; then
		ewarn
		ewarn "A shutdown-file has been changed."
		ewarn "You really have to execute"
		ewarn "\temerge --config gentoo-vdr-scripts"
		ewarn "to keep shutdown working."
		ewarn

		ebeep 5
	else
		elog
		elog "To make shutdown work add this line to /etc/sudoers"
		elog "\t$VDRSUDOENTRY"
		elog
		elog "or execute this command:"
		elog "\temerge --config gentoo-vdr-scripts"
		elog
	fi

	if ! use nvram ; then
		elog "nvram wakeup is now optional."
		elog "To make use of it enable the use flag nvram for ${PN}"
		elog "or just emerge nvram-wakeup."
	fi

	if has_version "<media-tv/gentoo-vdr-scripts-0.3.7"; then
		einfo
		einfo "Plugins which should be used are now set via its"
		einfo "own config-file called /etc/conf.d/vdr.plugins"
		einfo
		einfo "Smart updating should have moved all your settings"
		einfo
	fi

	if [[ -f "${ROOT}/etc/init.d/dvbsplash" ]]; then
		ewarn
		ewarn "You have dvbsplash installed!"
		ewarn "/etc/init.d/dvbsplash will now be deleted"
		ewarn "as it causes difficult to debug problems."
		ewarn
		rm "${ROOT}/etc/init.d/dvbsplash"
	fi
}

pkg_config() {
	if grep -q /usr/share/vdr/bin/vdrshutdown-really.sh ${ROOT}/etc/sudoers; then
		einfo "sudoers-entry for vdr already in place."
	else
		einfo "Adding this line to /etc/sudoers:"
		einfo "+  ${VDRSUDOENTRY}"

		cd ${T}
		cat >sudoedit-vdr.sh <<-SUDOEDITOR
			#!/bin/bash
			echo Commenting out old entry
			sed -i \${1} -e '/\/usr\/lib\/vdr\/bin\/vdrshutdown-really.sh/s/^/#/'
			echo Adding new entry
			echo "" >> \${1}
			echo "${VDRSUDOENTRY}" >> \${1}
		SUDOEDITOR
		chmod a+x sudoedit-vdr.sh

		VISUAL=${T}/sudoedit-vdr.sh visudo -f ${ROOT}/etc/sudoers || die "visudo failed"

		einfo "Edited /etc/sudoers"
	fi
}
