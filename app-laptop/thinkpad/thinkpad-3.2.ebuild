# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/thinkpad/thinkpad-3.2.ebuild,v 1.6 2006/01/11 15:34:27 config Exp $

#transform P to match tarball versioning
MYPV=${PV/_beta/beta}
MYP="${PN}_${MYPV}"
KV=""
DESCRIPTION="Thinkpad system control kernel modules"
HOMEPAGE="http://tpctl.sourceforge.net/tpctlhome.htm"
SRC_URI="mirror://sourceforge/tpctl/${MYP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"

pkg_setup() {
	check_KV
}

src_compile() {
	emake || die "Make failed"
}

src_install() {
	dodoc AUTHORS ChangeLog README SUPPORTED-MODELS TECHNOTES
	dodir /lib/modules/${KV}/thinkpad
	cp ${S}/drivers/{thinkpad,smapi,superio,rtcmosram,thinkpadpm}.o \
		${D}/lib/modules/${KV}/thinkpad
	insinto /etc/modules.d
	doins ${FILESDIR}/thinkpad
	(cat /etc/devfsd.conf; echo; echo '# Thinkpad config';
		echo 'REGISTER ^thinkpad/.*$    PERMISSIONS root.thinkpad  0664') \
		> ${D}/etc/devfsd.conf
}

pkg_postinst() {
	[ "${ROOT}" == "/" ] && /usr/sbin/update-modules
}
