# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/openmoko-dfu-util/openmoko-dfu-util-9999.ebuild,v 1.6 2009/12/01 22:32:33 vapier Exp $

EAPI="2"

inherit autotools
if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="http://svn.openmoko.org/trunk/src/host/dfu-util/"
	inherit subversion
	SRC_URI=""
	#KEYWORDS=""
else
	MY_P="${PN}-svn-${PV}"
	SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${MY_P}
fi

DESCRIPTION="implements the Host (PC) side of the USB DFU (Device Firmware Upgrade) protocol"
HOMEPAGE="http://wiki.openmoko.org/wiki/Dfu-util"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/libusb:0"
RDEPEND="${DEPEND}"

maint_pkg_create() {
	cd "${T}"
	svn export "${ESVN_STORE_DIR}/${PN}/dfu-util" ${PN}-svn-${ESVN_REVISION}
	cd ${PN}-svn-${ESVN_REVISION}
	sed -i '/^bin_PROGRAMS/s:dfu-util_static::' src/Makefile.am
	eautoreconf
	rm -rf autom4te.cache
	cd ..
	tar jcf ${PN}-svn-${ESVN_REVISION}.tar.bz2 ${PN}-svn-${ESVN_REVISION}
}

src_prepare() {
	if [[ ${PV} == "9999" ]] ; then
		subversion_src_prepare
		sed -i '/^bin_PROGRAMS/s:dfu-util_static::' src/Makefile.am
		eautoreconf
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "Make install failed"
	doman doc/dfu-util.1
}
