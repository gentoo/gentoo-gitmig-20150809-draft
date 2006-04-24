# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/linuxtv-dvb-apps/linuxtv-dvb-apps-1.1.0_p20060423.ebuild,v 1.1 2006/04/24 08:35:30 zzam Exp $


inherit eutils

MY_P="${PN/linuxtv-/}-${PV/*_p/}"

IUSE="usb"
SLOT="0"
HOMEPAGE="http://www.linuxtv.org/"
DESCRIPTION="small utils for DVB to scan, zap, view signal strength, ..."
LICENSE="GPL-2"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
KEYWORDS="~amd64 ~x86"
S=${WORKDIR}/${MY_P}

DEPEND="usb? ( >=dev-libs/libusb-0.1.10a )"
RDEPEND="${DEPEND}"

src_unpack()
{
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-makefile.patch

	# disables compilation of ttusb_dec_reset which requires libusb
	if ! use usb; then
		sed -i util/Makefile \
			-e '/ttusb_dec_reset/d' \
			-e '/dib3000-watch/d'
	fi

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
	# interferes with variable in Makefile
	unset ARCH

	insinto /usr/bin
	emake bindir=/usr/bin datadir=/usr/share libdir=/usr/lib prefix=${D}/usr \
		DESTDIR=${D} INSTDIR=${T} install || die "install failed"

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
