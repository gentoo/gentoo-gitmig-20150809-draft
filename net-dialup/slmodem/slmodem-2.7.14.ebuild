# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/slmodem/slmodem-2.7.14.ebuild,v 1.2 2003/12/14 12:26:54 spyderous Exp $

DESCRIPTION="Driver for Smart Link modem"
HOMEPAGE="http://www.smlink.com/"
MY_P="${P/modem/mdm}"
SRC_URI="ftp://ftp.smlink.com/linux/unsupported/${MY_P}.tar.gz"
LICENSE="Smart-Link"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="virtual/glibc"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PF}-makefile-fixup.patch
}

src_compile() {
	emake || die
}

src_install() {
	make install || die

	dodoc README COPYRIGHT FAQ Changes

	# Executable to get regions and version
	exeinto /usr/bin
	doexe slver

	# Install /etc/{devfs,modules}.d/slmodem files
	insinto /etc/devfs.d/; newins ${FILESDIR}/${PN}-2.7.devfs ${PN}
	insinto /etc/modules.d/; newins ${FILESDIR}/${PN}-2.7.modules ${PN}
}

pkg_postinst() {
	# Make some devices if we aren't using devfs
	if [ ! -e ${ROOT}dev/.devfsd ] ; then
		ebegin "Creating /dev/ttySL* devices"
		local C="0"
		while [ "${C}" -lt "4" ]; do
			if [ ! -c ${ROOT}dev/ttySL${C} ]; then
				mknod ${ROOT}dev/ttySL${C} c 212 0
			fi
			C="`expr $C + 1`"
		done
		eend 0
	fi

	ebegin "Restarting devfsd to create /dev/modem symlink"
		killall -HUP devfsd
	eend 0

	echo
	einfo "You must edit /etc/modules.d/${PN} and run"
	einfo "modules-update to complete configuration."
}
