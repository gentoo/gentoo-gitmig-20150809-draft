# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/linuxtv-dvb-apps/linuxtv-dvb-apps-1.1.0_p20050702.ebuild,v 1.2 2005/07/08 12:04:28 zzam Exp $


inherit eutils

MY_P="${PN/linuxtv-/}-snapshot-${PV/*_p/}"

IUSE="usb"
SLOT="0"
HOMEPAGE="http://www.linuxtv.org/"
DESCRIPTION="small utils for DVB to scan, zap, view signal strength, ..."
LICENSE="GPL-2"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
KEYWORDS="~amd64 ~x86"
S=${WORKDIR}/${MY_P}

DEPEND="usb? ( dev-libs/libusb )"

src_unpack()
{
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo-makefile-corrections.patch
	epatch ${FILESDIR}/${P}-gentoo-datafiles.patch
	epatch ${FILESDIR}/${P}-gentoo-install-ca_zap.patch

	# disables compilation of ttusb_dec_reset which requires libusb
	use usb || sed -i util/Makefile -e '/ttusb_dec_reset/d'

	# do not compile test-progs
	sed -i Makefile -e '/-C test/d'
}

src_compile()
{
	# interferes with variable in Makefile
	unset ARCH

	emake bindir=/usr/bin datadir=/usr/share libdir=/usr/lib || die "failed to compile"
}

src_install()
{
	emake bindir=/usr/bin datadir=/usr/share libdir=/usr/lib DESTDIR=${D} INSTDIR=${T} install || die "install failed"

	dodoc README TODO INSTALL
	newdoc util/scan/README README.dvbscan
	newdoc util/szap/README README.zap
	newdoc util/av7110_loadkeys/README README.av7110_loadkeys

	use usb && newdoc util/ttusb_dec_reset/READEM README.ttusb_dec_reset
}

pkg_postinst()
{
	einfo "Please read the documentation in /usr/share/doc/${PF}."
	einfo "The channel lists and other files are installed in"
	einfo "/usr/share/dvb"
	einfo
	einfo "The scanning utility is now installed as dvbscan."
}
