# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/thinkpad/thinkpad-4.1.ebuild,v 1.6 2006/01/11 15:34:27 config Exp $

#transform P to match tarball versioning
MYPV=${PV/_beta/beta}
MYP="${PN}_${MYPV}"
DESCRIPTION="Thinkpad system control kernel modules"
HOMEPAGE="http://tpctl.sourceforge.net/tpctlhome.htm"
SRC_URI="mirror://sourceforge/tpctl/${MYP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"

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
	dodoc AUTHORS ChangeLog README SUPPORTED-MODELS TECHNOTES
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
	[ "${ROOT}" == "/" ] && /usr/sbin/update-modules
}
