# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/noad/noad-0.6.0-r9.ebuild,v 1.10 2011/04/06 17:33:09 idl0r Exp $

inherit eutils autotools

DESCRIPTION="Mark commercial Breaks in VDR records"
HOMEPAGE="http://noad.heliohost.org/"
SRC_URI="http://noad.heliohost.org/oldv/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="ffmpeg imagemagick"

DEPEND="media-libs/libmpeg2
	ffmpeg? ( >=virtual/ffmpeg-0.4.8 )
	imagemagick? ( >=media-gfx/imagemagick-6.2.4.2-r1 )"
RDEPEND="${DEPEND}"

src_unpack() {

	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/patches-${PV}/directoryfix.diff
	epatch "${FILESDIR}"/patches-${PV}/as-needed.diff
	epatch "${FILESDIR}"/patches-${PV}/cflags.diff
	epatch "${FILESDIR}"/patches-${PV}/framesize.diff
	epatch "${FILESDIR}"/patches-${PV}/delete-while-scanning.diff
	epatch "${FILESDIR}"/patches-${PV}/fix-osd.patch
	epatch "${FILESDIR}"/patches-${PV}/hangcheck.diff
	epatch "${FILESDIR}"/patches-${PV}/new-ffmpeg-extern-c.diff
	epatch "${FILESDIR}"/patches-${PV}/lavc.patch

	sed -e "s:char \*indents:const char \*indents:" -i showindex.cpp

	if has_version ">=virtual/ffmpeg-0.4.9_p20080326" ; then
		sed -e "s:include/ffmpeg:include/libavcodec:g" -i configure.ac
	fi

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

	dodoc README INSTALL
	# example scripts are installed as dokumentation
	dodoc allnewnoad allnoad allnoadnice clearlogos noadifnew stat2html

	CONF_SOURCE="${FILESDIR}/0.6.0-r7"
	newconfd "${CONF_SOURCE}"/confd_vdraddon.noad vdraddon.noad

	insinto /usr/share/vdr/record
	doins "${CONF_SOURCE}"/record-50-noad.sh

	insinto /usr/share/vdr/shutdown
	doins "${FILESDIR}"/pre-shutdown-15-noad.sh

	insinto /etc/vdr/reccmds
	doins "${CONF_SOURCE}"/reccmds.noad.conf

	exeinto /usr/share/vdr/bin
	doexe "${CONF_SOURCE}"/noad-reccmd
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
	elog "noad now contains a hangcheck timer, to kill noad"
	elog "if it runs longer than 30 minutes."
}
