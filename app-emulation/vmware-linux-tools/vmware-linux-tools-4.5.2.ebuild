# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-linux-tools/vmware-linux-tools-4.5.2.ebuild,v 1.1 2005/02/18 00:38:09 stuart Exp $

inherit eutils

DESCRIPTION="Guest-os tools for VMWare workstation"
HOMEPAGE="http://www.vmware.com/"

# the vmware-tools sources are part of the vmware virtual machine;
# they must be installed by hand
SRC_URI="http://www.vmware/com/${PN}.tar.gz"
LICENSE="vmware"
SLOT="0"
KEYWORDS="~x86"
IUSE="X"
RESTRICT="fetch"

DEPEND=""
#RDEPEND=""

S=${WORKDIR}/vmware-tools-distrib

src_install() {
	# install the binaries
	dosbin sbin/vmware-checkvm
	dosbin sbin/vmware-guestd
	dobin bin/vmware-config-tools.pl
	dobin bin/vmware-toolbox

	# NOTE: we deliberately do NOT install the vmware-uninstall-tools.pl
	# script
	#
	# if you want to uninstall vmware from this machine, use Portage!

	# install the config files
	insinto /etc/vmware-tools
	for x in \
		installer.sh \
		not_configured \
		poweroff-vm-default \
		poweron-vm-default \
		resume-vm-default \
		suspend-vm-default \
	; do
		doins etc/$x
	done

	# populate the locations file
	# we replace the timestamp in that file with the current
	# timestamp

	insinto /etc/vmware-tools
	doins ${FILESDIR}/${PV}/locations
	timestamp="`date '+%s'`"
	sed -i "s|1109770680|$timestamp|g" ${D}/etc/vmware-tools/locations

	# install the library files
	mkdir -p ${D}/usr/lib/vmware-tools
	cp -r lib/* ${D}/usr/lib/vmware-tools

	# install the init scripts
	doinitd ${FILESDIR}/${PV}/${PN}

	# if we have X, install the default config
	if useq X ; then
		insinto /etc/X11
		doins ${FILESDIR}/${PV}xorg.conf
	fi

	# and we're done
}

pkg_postinst ()
{
	einfo "To start using the vmware-tools, please run the following:"
	einfo
	einfo "  /usr/bin/vmware-config-tools.pl"
	einfo "  rc-update add vmware-linux-tools default"
	einfo "  /etc/init.d/vmware-linux-tools start"
	einfo
	einfo "Please report all bugs to http://bugs.gentoo.org/"
}
