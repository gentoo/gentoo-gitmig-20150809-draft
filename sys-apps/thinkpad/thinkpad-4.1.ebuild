# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/thinkpad/thinkpad-4.1.ebuild,v 1.3 2003/06/21 21:19:41 drobbins Exp $

#transform P to match tarball versioning
MYPV=${PV/_beta/beta}
MYP="${PN}_${MYPV}"
DESCRIPTION="Thinkpad system control kernel modules"
SRC_URI="mirror://sourceforge/tpctl/${MYP}.tar.gz"
HOMEPAGE="http://tpctl.sourceforge.net/tpctlhome.htm"
KEYWORDS="x86 amd64 -ppc -mips"
SLOT="0"
LICENSE="GPL-2"

#virtual/glibc should depend on specific kernel headers
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} || die
	cd ${S}

	# These instructions come from the webpage and make it compile
	# on Linux 2.4
	mkdir 2.5
	mv drivers include 2.5
	ln -s 2.4/drivers drivers
	ln -s 2.4/include include
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
	(cat /etc/devfsd.conf; echo; echo '# Thinkpad config';
		echo 'REGISTER ^thinkpad/.*$    PERMISSIONS root.thinkpad  0664') \
		> ${D}/etc/devfsd.conf
}

pkg_postinst() {
	/usr/sbin/update-modules || return 0
}

pkg_prerm() {
	/sbin/modprobe -r smapi superion rtcmosram thinkpadpm thinkpad
}
