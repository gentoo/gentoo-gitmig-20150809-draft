# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/slmodem/slmodem-2.9.7.ebuild,v 1.4 2004/07/01 22:10:03 eradicator Exp $

inherit eutils

DESCRIPTION="Driver for Smart Link modem"
HOMEPAGE="http://www.smlink.com/"
MY_P="${P}"
SRC_URI="ftp://ftp.smlink.com/linux/unsupported/${MY_P}.tar.gz"
LICENSE="Smart-Link"
SLOT="0"
KEYWORDS="~x86"
IUSE="alsa"
RDEPEND="virtual/libc"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PF}-makefile-fixup.patch
}

src_compile() {
	if has sandbox ${FEATURES} || has userpriv $FEATURES; then
		ewarn "Users emerging this with a 2.6 kernel still need to disable"
		ewarn "sandbox and userpriv from FEATURES."
		die "bad FEATURES"
	fi
	unset ARCH
	if use alsa
	then
		emake SUPPORT_ALSA=1 MODVERDIR=${T}/.tmp_versions || die 'Alsa support failed, try USE="-alsa"'
	else
		emake || die "Could not compile"
	fi
}

src_install() {
	unset ARCH
	emake DESTDIR=${D} install || die

	dodoc COPYING Changes README README.1st

	# Install /etc/{devfs,modules,init,conf}.d/slmodem files
	insinto /etc/devfs.d/; newins ${FILESDIR}/${PN}-2.9.devfs ${PN}
	insinto /etc/modules.d/; newins ${FILESDIR}/${PN}-2.9.modules ${PN}
	insinto /etc/conf.d/; newins ${FILESDIR}/${PN}-2.9.conf ${PN}
	insopts -m0755; insinto /etc/init.d/; newins ${FILESDIR}/${PN}-2.9.init ${PN}

	# Make some devices if we aren't using devfs
	# If we are using devfs, restart it
	if [ ! -e ${ROOT}/dev/.devfsd ]
	then
		dodir /dev
		ebegin "Creating /dev/ttySL* devices"
		local C="0"
		while [ "${C}" -lt "4" ]
		do
			if [ ! -c ${ROOT}/dev/ttySL${C} ]
			then
				mknod ${D}/dev/ttySL${C} c 212 0
			fi
			C="`expr $C + 1`"
		done
		eend 0
	fi

}

pkg_postinst() {
	# Make some devices if we aren't using devfs
	# If we are using devfs, restart it
	if [ -e ${ROOT}/dev/.devfsd ]
	then
		ebegin "Restarting devfsd to create /dev/modem symlink"
			killall -HUP devfsd
		eend 0
	fi

	echo
	einfo "You must edit /etc/conf.d/${PN} and run"
	einfo "modules-update to complete configuration."
}
