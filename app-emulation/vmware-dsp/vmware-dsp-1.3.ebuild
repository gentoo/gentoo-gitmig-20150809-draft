# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-dsp/vmware-dsp-1.3.ebuild,v 1.4 2007/07/13 00:36:15 wolf31o2 Exp $

inherit eutils multilib

MY_PN=${PN/-/}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Allows you to use VMware Workstation with ESD and ARTS."
HOMEPAGE="http://ftp.cvut.cz/vmware/"
SRC_URI="http://platan.vc.cvut.cz/ftp/pub/vmware/${MY_P}.tar.gz
	http://ftp.cvut.cz/vmware/${MY_P}.tar.gz
	http://ftp.cvut.cz/vmware/obsolete/${MY_P}.tar.gz
	http://knihovny.cvut.cz/ftp/pub/vmware/${MY_P}.tar.gz
	http://knihovny.cvut.cz/ftp/pub/vmware/obsolete/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="arts esd"
RESTRICT=""

RDEPEND="sys-libs/glibc
	amd64? (
		app-emulation/emul-linux-x86-soundlibs
		esd? ( media-sound/esound )
		arts? ( kde-base/arts ) )
	x86? (
		esd? ( media-sound/esound )
		arts? ( kde-base/arts ) )"

S=${WORKDIR}/${MY_P}

dir=/opt/vmware/dsp
Ddir=${D}/${dir}

src_compile() {
	cd "${S}"/src
	if use arts && use esd
	then
		einfo "Building both aRts and ESD support."
	elif use arts
	then
		einfo "Building aRts support only."
		sed -i '/PLUGINS :=/ s/ libvmdsp_esd.so//' 32/Makefile 64/Makefile \
			|| die "sed failed"
	else
		einfo "Building ESD support only."
		sed -i '/PLUGINS :=/ s/ libvmdsp_arts.so//' 32/Makefile 64/Makefile \
			|| die "sed failed"
	fi
	if use x86
	then
		cd 32
		emake -j1 || die
	elif has_multilib_profile
	then
		emake -j1 || die
	else
		cd 64
		emake -j1 || die
	fi
}

src_install() {
	cd "${S}"
	if use x86
	then
		dolib src/32/libvmdsp*.so || die "Copying libraries"
	elif has_multilib_profile
	then
		exeinto /usr/lib32
		doexe src/32/libvmdsp*.so || die
		dolib src/64/libvmdsp*.so || die
	else
		src/64/libvmdsp*.so || die
	fi
	if use arts
	then
		dobin vmwarearts || die
		make_desktop_entry vmwarearts "VMware Workstation (aRts)" \
			vmware-workstation.png System
	fi
	if use esd
	then
		dobin vmwareesd || die
		make_desktop_entry vmwareesd "VMware Workstation (ESD)" \
			vmware-workstation.png System
	fi
}
