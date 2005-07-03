# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/dvb-apps/dvb-apps-1.1.0_p20050702.ebuild,v 1.2 2005/07/03 12:33:25 zzam Exp $


inherit eutils

MY_P="${PN}-${PV/*_p/snapshot-}"

IUSE="usb"
SLOT="0"
HOMEPAGE="http://www.linuxtv.org/"
DESCRIPTION="small utils for DVB to scan, zap, view signal strength, ..."
LICENSE="GPL-2"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
KEYWORDS="~x86"
S=${WORKDIR}/${MY_P}

DEPEND="usb? ( dev-libs/libusb )"

src_unpack()
{
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo-makefile-corrections.patch
	epatch ${FILESDIR}/${P}-gentoo-datafiles.patch

	# disables compilation of ttusb_dec_reset which requires libusb
	use usb || sed -i.orig util/Makefile -e '/ttusb_dec_reset/d'
}

src_compile()
{
	# interferes with variable in Makefile
	unset ARCH

	emake bindir=/usr/bin datadir=/usr/share libdir=/usr/lib || die "failed to compile"
}

src_install()
{
	make bindir=/usr/bin datadir=/usr/share libdir=/usr/lib DESTDIR=${D} INSTDIR=${T} install || die "install failed"

	dodoc README TODO INSTALL
	newdoc util/scan/README README.dvbscan
	newdoc util/szap/README README.zap
	newdoc util/av7110_loadkeys/README README.av7110_loadkeys

	use usb && newdoc util/ttusb_dec_reset/READEM README.ttusb_dec_reset
}
