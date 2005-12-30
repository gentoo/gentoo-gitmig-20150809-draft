# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/gentoo-vdr-scripts/gentoo-vdr-scripts-0.2_alpha6.ebuild,v 1.1 2005/12/30 23:11:39 zzam Exp $

inherit eutils

IUSE="nvram"

SRC_URI="http://dev.gentoo.org/~zzam/distfiles/${P}.tgz"
DESCRIPTION="scripts necessary for use of vdr as a set-top-box"
HOMEPAGE="http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="nvram? ( x86? ( sys-power/nvram-wakeup ) )"

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

	cd ${S}/usr/lib/vdr/shutdown
	insinto /usr/lib/vdr/shutdown
	doins wakeup-acpi.sh
	if use nvram; then
		if use x86; then
			doins wakeup-nvram.sh
		else
			ewarn "nvram-wakeup is not available on this architecture."
		fi
	fi

	keepdir /var/vdr/shutdown-data
	keepdir /var/vdr/merged-config-files
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

pkg_postinst() {
	einfo "This release has included"
	einfo "shutdown/wakeup-functions."
	einfo
	einfo "Please add this line to your /etc/sudoers-file"
	einfo "     vdr ALL=NOPASSWD:/usr/lib/vdr/bin/vdrshutdown-really.sh"
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
