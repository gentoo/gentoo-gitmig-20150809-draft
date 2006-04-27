# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/gentoo-vdr-scripts/gentoo-vdr-scripts-0.3.0.ebuild,v 1.2 2006/04/27 14:11:28 zzam Exp $

inherit eutils

IUSE="nvram"

SRC_URI="mirror://gentoo/${P}.tar.bz2"
DESCRIPTION="scripts necessary for use of vdr as a set-top-box"
HOMEPAGE="http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc x86"

RDEPEND="nvram? ( x86? ( sys-power/nvram-wakeup ) )
		app-admin/sudo"

VDR_HOME=/var/vdr

pkg_setup() {
	enewgroup vdr
	if getent passwd vdr >/dev/null 2>&1; then
		einfo "Modifying user vdr"
		usermod -g vdr -s /bin/bash vdr
		local grp
		for grp in video audio cdrom; do
			gpasswd -a vdr ${grp} >/dev/null
		done
	else
		enewuser vdr -1 /bin/bash ${VDR_HOME} vdr,video,audio,cdrom
	fi
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc README TODO ChangeLog

	if use nvram; then
		if use x86; then
			make install-nvram DESTDIR="${D}" || die "make install-nvram failed"
		else
			ewarn "nvram-wakeup is not available on this architecture."
		fi
	fi

	keepdir /var/vdr/shutdown-data
	keepdir /var/vdr/merged-config-files
	keepdir /var/vdr/video/dvd-images
	chown vdr:vdr -R ${D}/var/vdr
}

pkg_preinst() {
	local owner
	local d
	for d in /etc/vdr /var/vdr; do
		if [[ -d ${d} ]]; then
			owner=$(stat ${d} -c "%U")
			if [[ ${owner} != vdr ]]; then
				einfo "Changing ownership of ${d}"
				chown -R vdr:vdr ${d}
			fi
		fi
	done
}

VDRSUDOENTRY="vdr ALL=NOPASSWD:/usr/lib/vdr/bin/vdrshutdown-really.sh"

pkg_postinst() {
	einfo
	einfo "To make shutdown work add this line to /etc/sudoers"
	einfo "    $VDRSUDOENTRY"
	einfo
	einfo "or execute this command:"
	einfo "    emerge --config gentoo-vdr-scripts"
	einfo
	ewarn "The default video directory was moved to /var/vdr/video"
	ewarn "If you have your video directory anywhere else, then"
	ewarn "change the setting VIDEO in the file /etc/conf.d/vdr."
	ewarn
	if use x86 && use !nvram; then
		ewarn "nvram wakeup is now optional."
		ewarn "To make use of it enable the use flag nvram."
	fi
}

pkg_config() {
	if grep -q /usr/lib/vdr/bin/vdrshutdown-really.sh ${ROOT}/etc/sudoers; then
		einfo "sudoers-entry for vdr already in place."
	else
		einfo "Adding this line to /etc/sudoers:"
		einfo "+  ${VDRSUDOENTRY}"

		cd ${T}
		cat >sudoedit-vdr.sh <<-SUDOEDITOR
			#!/bin/bash
			echo "" >> \${1}
			echo "${VDRSUDOENTRY}" >> \${1}
		SUDOEDITOR
		chmod a+x sudoedit-vdr.sh

		VISUAL=${T}/sudoedit-vdr.sh visudo -f ${ROOT}/etc/sudoers || die "visudo failed"

		einfo "Edited /etc/sudoers"
	fi
}

