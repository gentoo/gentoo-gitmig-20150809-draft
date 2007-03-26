# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/linuxtv-dvb-apps/linuxtv-dvb-apps-1.1.1.20070114.ebuild,v 1.3 2007/03/26 20:53:23 armin76 Exp $


inherit eutils versionator

MY_P="${PN}-$(get_version_component_range 4)"

IUSE="usb"
SLOT="0"
HOMEPAGE="http://www.linuxtv.org/"
DESCRIPTION="small utils for DVB to scan, zap, view signal strength, ..."
LICENSE="GPL-2"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"

RDEPEND="usb? ( >=dev-libs/libusb-0.1.10a )"
DEPEND="${DEPEND}
	media-tv/linuxtv-dvb-headers"

S=${WORKDIR}/${MY_P}

src_unpack()
{
	unpack ${A}

	cd ${S}
	# disables compilation of ttusb_dec_reset which requires libusb
	if ! use usb; then
		sed -i util/Makefile \
			-e '/ttusb_dec_reset/d' \
			-e '/dib3000-watch/d'
	fi

	# do not compile test-progs
	sed -i Makefile -e '/-C test/d'

	# remove copy of header-files
	rm -rf ${S}/include
}

src_compile()
{
	# interferes with variable in Makefile
	unset ARCH

	emake bindir=/usr/bin datadir=/usr/share libdir=/usr/$(get_libdir) || die "failed to compile"
}

src_install()
{
	# interferes with variable in Makefile
	unset ARCH

	insinto /usr/bin
	emake bindir=/usr/bin datadir=/usr/share libdir=/usr/$(get_libdir) prefix=/usr \
		DESTDIR=${D} INSTDIR=${T} install || die "install failed"

	# rename scan to dvbscan
	mv ${D}/usr/bin/scan ${D}/usr/bin/dvbscan

	# install scan-files
	local dir
	for dir in dvb-{s,c,t} atsc; do
		insinto /usr/share/dvb/scan/${dir}
		doins ${S}/util/scan/${dir}/*
	done

	# install zap-files
	for dir in dvb-{s,c,t} atsc; do
		insinto /usr/share/dvb/zap/${dir}
		doins ${S}/util/szap/channels-conf/${dir}/*
	done

	# install remote-key files
	insinto /usr/share/dvb/av7110_loadkeys
	doins ${S}/util/av7110_loadkeys/*.rc*

	# install Documentation
	dodoc README TODO INSTALL
	newdoc util/scan/README README.dvbscan
	newdoc util/szap/README README.zap
	newdoc util/av7110_loadkeys/README README.av7110_loadkeys

	use usb && newdoc util/ttusb_dec_reset/README README.ttusb_dec_reset
}

pkg_postinst()
{
	elog "Please read the documentation in /usr/share/doc/${PF}."
	elog "The channel lists and other files are installed in"
	elog "/usr/share/dvb"
	elog
	elog "The scanning utility is now installed as dvbscan."
}
