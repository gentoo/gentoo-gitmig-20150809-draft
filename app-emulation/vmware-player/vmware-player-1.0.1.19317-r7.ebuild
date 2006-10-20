# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-player/vmware-player-1.0.1.19317-r7.ebuild,v 1.2 2006/10/20 04:37:02 tsunam Exp $

# Unlike many other binary packages the user doesn't need to agree to a licence
# to download VMWare. The agreeing to a licence is part of the configure step
# which the user must run manually.

inherit eutils vmware

S=${WORKDIR}/vmware-player-distrib
MY_P="VMware-player-1.0.1-19317"
DESCRIPTION="Emulate a complete PC on your PC without the usual performance overhead of most emulators"
HOMEPAGE="http://www.vmware.com/products/player/"
SRC_URI="http://download3.vmware.com/software/vmplayer/${MY_P}.tar.gz
	http://ftp.cvut.cz/vmware/${ANY_ANY}.tar.gz
	http://ftp.cvut.cz/vmware/obselete/${ANY_ANY}.tar.gz
	http://knihovny.cvut.cz/ftp/pub/vmware/${ANY_ANY}.tar.gz
	http://knihovny.cvut.cz/ftp/pub/vmware/obselete/${ANY_ANY}.tar.gz
	http://dev.gentoo.org/~wolf31o2/sources/dump/vmware-libssl.so.0.9.7l.tar.bz2
	mirror://gentoo/vmware-libssl.so.0.9.7l.tar.bz2
	http://dev.gentoo.org/~wolf31o2/sources/dump/vmware-libcrypto.so.0.9.7l.tar.bz2
	mirror://gentoo/vmware-libcrypto.so.0.9.7l.tar.bz2"

LICENSE="vmware"
IUSE=""
SLOT="0"
KEYWORDS="-* ~amd64 x86"
RESTRICT="strip" # fetch"

DEPEND="${RDEPEND} virtual/os-headers
	!app-emulation/vmware-workstation"
# vmware-player should not use virtual/libc as this is a 
# precompiled binary package thats linked to glibc.
RDEPEND="sys-libs/glibc
	amd64? (
		app-emulation/emul-linux-x86-gtklibs )
	x86? (
		x11-libs/libXrandr
		x11-libs/libXcursor
		x11-libs/libXinerama
		x11-libs/libXi
		virtual/xft )
	>=dev-lang/perl-5
	!app-emulation/vmware-workstation
	!app-emulation/vmware-server
	~app-emulation/vmware-modules-1.0.0.13
	sys-apps/pciutils"

RUN_UPDATE="no"

dir=/opt/vmware/player
Ddir=${D}/${dir}

src_install() {
	vmware_src_install

	make_desktop_entry vmplayer "VMWare Player" ${PN}.png
}
