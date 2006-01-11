# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/thinkpad/thinkpad-5.7.ebuild,v 1.4 2006/01/11 15:34:27 config Exp $

inherit eutils

#transform P to match tarball versioning
MYPV=${PV/_beta/beta}
MYP="${PN}_${MYPV}"
DESCRIPTION="Thinkpad system control kernel modules"
HOMEPAGE="http://tpctl.sourceforge.net/tpctlhome.htm"
SRC_URI="mirror://sourceforge/tpctl/${MYP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

DEPEND="virtual/libc"

pkg_setup() {
	enewgroup thinkpad
}

src_unpack() {
	check_KV
	unpack ${A} || die
	cd ${S}
	local ver=${KV:0:3} # first 3 chars of $KV, thank you bash :)
	ln -s $ver/drivers drivers
	ln -s $ver/include include
}

src_compile() {
	unset ARCH
	MAKEOPTS="" emake all || die "Make failed"
}

src_install() {
	dodoc AUTHORS ChangeLog README SUPPORTED-MODELS TECHNOTES
	dodir /lib/modules/${KV}/thinkpad
	[ -e "${S}/drivers/thinkpad.ko" ] && MOD="ko" || MOD="o"
	cp ${S}/drivers/{thinkpad,smapi,superio,rtcmosram,thinkpadpm}.${MOD} \
		${D}/lib/modules/${KV}/thinkpad
	dodir /etc/modules.d
	sed 's/%KV%/'${KV}'/g' ${FILESDIR}/thinkpad > ${D}/etc/modules.d/thinkpad
	dodir /etc/devfs.d
	echo 'REGISTER ^thinkpad/.*$    PERMISSIONS root.thinkpad  0664' \
		> ${D}/etc/devfs.d/thinkpad
	doman man/*.4
}

pkg_postinst() {
	[ "${ROOT}" == "/" ] && /usr/sbin/update-modules
	if ! grep -q '^ *INCLUDE.*devfs\.d' /etc/devfsd.conf; then
		ewarn 'Your /etc/devfsd.conf is missing the include for'
		ewarn '/etc/devfs.d/! Please fix this by adding'
		ewarn 'INCLUDE /etc/devfs.d'
		ewarn 'to your /etc/devfs.conf'
	fi
	if grep -q thinkpad /etc/devfsd.conf; then
		ewarn 'The thinkpad devfsd entry has moved to'
		ewarn '/etc/devfs.d/thinkpad, so you can remove it from'
		ewarn '/etc/devfsd.conf if you like.'
	fi
}
