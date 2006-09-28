# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-workstation/vmware-workstation-3.2.1.2242-r12.ebuild,v 1.3 2006/09/28 16:32:10 wolf31o2 Exp $

# Alter ebuild so that the metadata cache is invalidated.

inherit toolchain-funcs eutils vmware

MY_P="VMware-workstation-3.2.1-2242"

DESCRIPTION="Emulate a complete PC on your PC without the usual performance overhead of most emulators"
HOMEPAGE="http://www.vmware.com/products/desktop/ws_features.html"
SRC_URI="mirror://vmware/software/${MY_P}.tar.gz
	http://ftp.cvut.cz/vmware/${ANY_ANY}.tar.gz
	http://ftp.cvut.cz/vmware/obsolete/${ANY_ANY}.tar.gz
	http://knihovny.cvut.cz/ftp/pub/vmware/${ANY_ANY}.tar.gz
	http://knihovny.cvut.cz/ftp/pub/vmware/obselete/${ANY_ANY}.tar.gz
	mirror://gentoo/vmware.png"

LICENSE="vmware"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""
# Even with all of the QA_* variables below, we still need this because there is
# no QA variable for setXid lazy bindings.  Sorry, guys.
RESTRICT="stricter strip"

# vmware-workstation should not use virtual/libc as this is a
# precompiled binary package thats linked to glibc.
RDEPEND="sys-libs/glibc
	x11-libs/libXrandr
	x11-libs/libXcursor
	x11-libs/libXinerama
	x11-libs/libXi
	virtual/xft
	!app-emulation/vmware-player
	!app-emulation/vmware-server
	~app-emulation/vmware-modules-1.0.0.8
	media-libs/gdk-pixbuf
	>=dev-lang/perl-5
	sys-apps/pciutils"

S=${WORKDIR}/vmware-distrib

RUN_UPDATE="no"

dir=/opt/vmware/workstation
Ddir=${D}/${dir}

QA_TEXTRELS_x86="${dir:1}/lib/lib/libgdk-x11-2.0.so.0/libgdk-x11-2.0.so.0"
QA_EXECSTACK_x86="${dir:1}/bin/vmnet-bridge
	${dir:1}/bin/vmnet-dhcpd
	${dir:1}/bin/vmnet-natd
	${dir:1}/bin/vmnet-netifup
	${dir:1}/bin/vmnet-sniffer
	${dir:1}/bin/vmware-loop
	${dir:1}/bin/vmware-ping
	${dir:1}/bin/vmware-vdiskmanager
	${dir:1}/lib/bin/vmware
	${dir:1}/lib/bin/vmware-vmx
	${dir:1}/lib/bin/vmrun
	${dir:1}/lib/bin/vmplayer
	${dir:1}/lib/bin-debug/vmware-vmx
	${dir:1}/lib/lib/libpixops.so.2.0.1/libpixops.so.2.0.1"

src_compile() {
	has_version '<sys-libs/glibc-2.3.2' \
		&& GLIBC_232=0 \
		|| GLIBC_232=1

	if [ ${GLIBC_232} -eq 1 ] ; then
		$(tc-getCC) -W -Wall -shared -o vmware-glibc-2.3.2-compat.so \
			${FILESDIR}/${PV}/vmware-glibc-2.3.2-compat.c \
			|| die "could not make module"
	else
		return 0
	fi
}

src_install() {
	vmware_src_install
	# We also remove libgdk_pixbuf stuff, to resolve bug #81344.
	rm -rf ${Ddir}/lib/lib/libgdk_pixbuf.so.2

	make_desktop_entry vmware "VMware Workstation" vmware.png

	if [ ${GLIBC_232} -eq 1 ] ; then
		dolib.so vmware-glibc-2.3.2-compat.so
		cd ${Ddir}/lib/bin
		mv vmware-ui{,.bin}
		mv vmware-mks{,.bin}
		echo '#!/bin/sh' > vmware-ui
		echo 'LD_PRELOAD=vmware-glibc-2.3.2-compat.so exec "$0.bin" "$@"' >> vmware-ui
		chmod a+x vmware-ui
		cp vmware-{ui,mks}
	else
		return 0
	fi
}
