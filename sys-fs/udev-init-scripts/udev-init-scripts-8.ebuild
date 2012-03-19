# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udev-init-scripts/udev-init-scripts-8.ebuild,v 1.4 2012/03/19 17:06:09 williamh Exp $

EAPI=4

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/udev-gentoo-scripts.git"

[ "${PV}" = "9999" ] && vcs=git-2
inherit $vcs
unset vcs

DESCRIPTION="udev startup scripts for openrc"
HOMEPAGE="http://www.gentoo.org"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

if [ "${PV}" != "9999" ]; then
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
	KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~x86"
fi

DEPEND=""
RDEPEND=">=sys-fs/udev-181
	!<sys-fs/udev-181
	sys-apps/openrc"

	src_compile()
{
	return 0
}

pkg_postinst()
{
	local enable_postmount=false

	# FIXME: inconsistent handling of init-scripts here
	#  * udev is added to sysinit in openrc-ebuild
	#  * we add udev-postmount to default in here
	#

	# If we are building stages, add udev to the sysinit runlevel automatically.
	if use build
	then
		if [[ -x "${ROOT}"/etc/init.d/udev  \
			&& -d "${ROOT}"/etc/runlevels/sysinit ]]
		then
			ln -s /etc/init.d/udev "${ROOT}"/etc/runlevels/sysinit/udev
		fi
		enable_postmount=true
	fi

	# migration to >=openrc-0.4
	if [[ -e "${ROOT}"/etc/runlevels/sysinit && ! -e "${ROOT}"/etc/runlevels/sysinit/udev ]]
	then
		ewarn
		ewarn "You need to add the udev init script to the runlevel sysinit,"
		ewarn "else your system will not be able to boot"
		ewarn "after updating to >=openrc-0.4.0"
		ewarn "Run this to enable udev for >=openrc-0.4.0:"
		ewarn "\trc-update add udev sysinit"
		ewarn
	fi

	# add udev-postmount to default runlevel instead of that ugly injecting
	# like a hotplug event, 2009/10/15

	# already enabled?
	[[ -e "${ROOT}"/etc/runlevels/default/udev-postmount ]] && return

	[[ -e "${ROOT}"/etc/runlevels/sysinit/udev ]] && enable_postmount=true
	[[ "${ROOT}" = "/" && -d /dev/.udev/ ]] && enable_postmount=true

	if $enable_postmount
	then
		local initd=udev-postmount

		if [[ -e ${ROOT}/etc/init.d/${initd} ]] && \
			[[ ! -e ${ROOT}/etc/runlevels/default/${initd} ]]
		then
			ln -snf /etc/init.d/${initd} "${ROOT}"/etc/runlevels/default/${initd}
			elog "Auto-adding '${initd}' service to your default runlevel"
		fi
	else
		elog "You should add the udev-postmount service to default runlevel."
		elog "Run this to add it:"
		elog "\trc-update add udev-postmount default"
	fi
}
