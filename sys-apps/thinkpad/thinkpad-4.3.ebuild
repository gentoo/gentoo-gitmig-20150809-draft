# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/thinkpad/thinkpad-4.3.ebuild,v 1.1 2003/05/04 13:19:50 wmertens Exp $

#transform P to match tarball versioning
MYPV=${PV/_beta/beta}
MYP="${PN}_${MYPV}"
DESCRIPTION="Thinkpad system control kernel modules"
SRC_URI="mirror://sourceforge/tpctl/${MYP}.tar.gz"
HOMEPAGE="http://tpctl.sourceforge.net/tpctlhome.htm"
KEYWORDS="~x86 -ppc -mips -sparc"
SLOT="0"
LICENSE="GPL-2"

#virtual/glibc should depend on specific kernel headers
DEPEND="virtual/glibc"

src_unpack() {
	check_KV
	unpack ${A} || die
	cd ${S}

	# Use the correct drivers for your kernel. The standard distro comes
	# with 2.5.
	mkdir 2.5
	mv drivers include 2.5
	# Use your kernel version to build.
	local ver=${KV:0:3} # first 3 chars of $KV, thank you bash :)
	ln -s $ver/drivers drivers
	ln -s $ver/include include
}

src_compile() {
	check_KV
	emake DIR_MOD_VER=/lib/modules/${KV} || die "Make failed"
}

src_install() {
	dodoc AUTHORS COPYING ChangeLog README SUPPORTED-MODELS TECHNOTES
	dodir /lib/modules/${KV}/thinkpad
	cp ${S}/drivers/{thinkpad,smapi,superio,rtcmosram,thinkpadpm}.o \
		${D}/lib/modules/${KV}/thinkpad
	dodir /etc/modules.d
	sed 's/%KV%/'${KV}'/g' ${FILESDIR}/thinkpad > ${D}/etc/modules.d/thinkpad
	dodir /etc/devfs.d
	echo 'REGISTER ^thinkpad/.*$    PERMISSIONS root.thinkpad  0664' \
		> ${D}/etc/devfs.d/thinkpad
}

pkg_postinst() {
	/usr/sbin/update-modules || return 0
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

pkg_prerm() {
	/sbin/modprobe -r smapi superion rtcmosram thinkpadpm thinkpad
}
