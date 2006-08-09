# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-workstation/vmware-workstation-4.5.3.19414-r4.ebuild,v 1.4 2006/08/09 23:18:13 wolf31o2 Exp $

# Alter ebuild so that the metadata cache is invalidated.

inherit eutils vmware

MY_P="VMware-workstation-4.5.3-19414"

DESCRIPTION="Emulate a complete PC on your PC without the usual performance overhead of most emulators"
HOMEPAGE="http://www.vmware.com/products/desktop/ws_features.html"
SRC_URI="mirror://vmware/software/wkst/${MY_P}.tar.gz
	http://ftp.cvut.cz/vmware/${ANY_ANY}.tar.gz
	http://ftp.cvut.cz/vmware/obselete/${ANY_ANY}.tar.gz
	http://knihovny.cvut.cz/ftp/pub/vmware/${ANY_ANY}.tar.gz
	http://knihovny.cvut.cz/ftp/pub/vmware/obselete/${ANY_ANY}.tar.gz
	mirror://gentoo/vmware.png"

LICENSE="vmware"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="strip"

# vmware-workstation should not use virtual/libc as this is a
# precompiled binary package thats linked to glibc.
RDEPEND="sys-libs/glibc
	amd64? (
		app-emulation/emul-linux-x86-gtklibs )
	x86? (
		|| (
			(
				x11-libs/libXrandr
				x11-libs/libXcursor
				x11-libs/libXinerama
				x11-libs/libXi )
			virtual/x11 )
		virtual/xft )
	!app-emulation/vmware-player
	!app-emulation/vmware-server
	~app-emulation/vmware-modules-1.0.0.11
	>=dev-lang/perl-5
	sys-apps/pciutils"

S=${WORKDIR}/vmware-distrib

RUN_UPDATE="no"

dir=/opt/vmware/workstation
Ddir=${D}/${dir}

src_install() {
	vmware_src_install
	# We remove the rpath libgdk_pixbuf stuff, to resolve bug #81344.
	perl -pi -e 's#/tmp/rrdharan/out#/opt/vmware/null/#sg' \
		${Ddir}/lib/lib/libgdk_pixbuf.so.2/lib{gdk_pixbuf.so.2,pixbufloader-{xpm,png}.so.1.0.0} \
		|| die "Removing rpath"

	make_desktop_entry vmware "VMWare Workstation" ${PN}.png
}
