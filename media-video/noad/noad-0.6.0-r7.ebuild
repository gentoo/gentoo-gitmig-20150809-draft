# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/noad/noad-0.6.0-r7.ebuild,v 1.2 2007/01/05 17:18:22 hd_brummy Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit eutils autotools

DESCRIPTION="Mark commercial Breaks in VDR records"
HOMEPAGE="http://www.freepgs.com/noad/"
SRC_URI="http://www.freepgs.com/${PN}/${P}.tar.bz2
		mirror://vdrfiles/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="ffmpeg imagemagick"

DEPEND="media-libs/libmpeg2
	media-video/vdr
	ffmpeg? ( >=media-video/ffmpeg-0.4.8 )
	imagemagick? ( >=media-gfx/imagemagick-6.2.4.2-r1 )"
RDEPEND=">=media-tv/gentoo-vdr-scripts-0.3.5"

src_unpack() {

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-directoryfix.diff
	epatch ${FILESDIR}/${P}-as-needed.diff
	epatch ${FILESDIR}/${P}-cflags.diff
	epatch ${FILESDIR}/${P}-framesize.diff
	epatch ${FILESDIR}/${P}-delete-while-scanning.diff
	epatch ${FILESDIR}/${P}-fix-osd.patch

	rm configure
	eautoreconf
}

src_compile() {

	econf \
		$(use_with ffmpeg) \
		$(use_with imagemagick magick) \
		--with-tools \
		--with-mpeginclude=/usr/include/mpeg2dec

	emake || die "emake faild"
}

src_install() {

	dobin noad showindex
	use imagemagick && dobin markpics

	dodoc COPYING README INSTALL
	# example scripts are installed as dokumentation
	dodoc allnewnoad allnoad allnoadnice clearlogos noadifnew stat2html

	CONF_SOURCE=${FILESDIR}/0.6.0-r7
	insinto /etc/conf.d
	newins ${CONF_SOURCE}/confd_vdraddon.noad vdraddon.noad

	insinto /usr/share/vdr/record
	doins ${CONF_SOURCE}/record-50-noad.sh

	insinto /etc/vdr/reccmds
	doins ${CONF_SOURCE}/reccmds.noad.conf

	exeinto /usr/share/vdr/bin
	doexe ${CONF_SOURCE}/noad-reccmd
}

pkg_postinst() {

	elog
	elog "Congratulations, you have just installed noad!,"
	elog "To integrate noad in VDR you should do this:"
	elog
	elog "start and set Parameter in /etc/conf.d/vdraddon.noad"
	elog
	elog "Note: You can use here all pararmeters for noad,"
	elog "please look in the documentation of noad."
	elog
}
