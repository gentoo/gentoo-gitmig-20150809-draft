# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/thinkpad/thinkpad-3.2.ebuild,v 1.5 2002/07/21 21:10:38 gerk Exp $

#transform P to match tarball versioning
MYPV=${PV/_beta/beta}
MYP="${PN}_${MYPV}"
KV=""
DESCRIPTION="Thinkpad system control kernel modules"
SRC_URI="mirror://sourceforge/tpctl/${MYP}.tar.gz"
HOMEPAGE="http://tpctl.sourceforge.net/tpctlhome.htm"
KEYWORDS="x86 -ppc"
SLOT="0"
LICENSE="GPL-2"

#virtual/glibc should depend on specific kernel headers
DEPEND="virtual/glibc"

pkg_setup() {
	#thinkpad will compile modules for the kernel pointed to by /usr/src/linux
	KV=`readlink /usr/src/linux`
	if [ $? -ne 0 ] ; then
		echo 
		echo "/usr/src/linux symlink does not exist; cannot continue."
		echo
		die
	else
		KV=${KV/linux-/}
	fi
}

src_compile () {

	emake || die "Make failed"

}

src_install () {
	
	dodoc AUTHORS COPYING ChangeLog README SUPPORTED-MODELS TECHNOTES
	dodir /lib/modules/${KV}/thinkpad
	cp ${S}/drivers/{thinkpad,smapi,superio,rtcmosram,thinkpadpm}.o \
		${D}/lib/modules/${KV}/thinkpad
	insinto /etc/modules.d
	doins ${FILESDIR}/thinkpad
	(cat /etc/devfsd.conf; echo; echo '# Thinkpad config';
		echo 'REGISTER ^thinkpad/.*$    PERMISSIONS root.thinkpad  0664') \
		> ${D}/etc/devfsd.conf
}

pkg_postinst () {
	/usr/sbin/update-modules || return 0
}

pkg_prerm () {
	/sbin/modprobe -r smapi superion rtcmosram thinkpadpm thinkpad
}
