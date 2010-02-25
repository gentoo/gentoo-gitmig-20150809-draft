# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/noad/noad-0.7.0.20100119.ebuild,v 1.2 2010/02/25 18:44:08 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Mark commercial Breaks in VDR records"
HOMEPAGE="http://noad.heliohost.org/"
SRC_URI="http://vdr.websitec.de/download/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ffmpeg imagemagick"

DEPEND="media-libs/libmpeg2
	ffmpeg? ( >=media-video/ffmpeg-0.4.8 )
	imagemagick? ( >=media-gfx/imagemagick-6.2.4.2-r1 )"
RDEPEND="${DEPEND}"

src_prepare() {

	epatch "${FILESDIR}"/patches-0.6.0/hangcheck.diff \
		"${FILESDIR}"/patches-0.7.x/${P}-asneeded.patch

	if has_version ">=media-video/ffmpeg-0.4.9_p20080326" ; then
		sed -e "s:include/ffmpeg:include/libavcodec:g" -i configure.ac
	fi

	rm configure
	eautoreconf
}

src_configure() {

	econf \
		$(use_with ffmpeg) \
		$(use_with imagemagick magick) \
		--with-tools \
		--with-mpeginclude=/usr/include/mpeg2dec
}

src_compile() {

	emake noad || die "emake faild"
}

src_install() {

	dobin noad
#	fix me later!
#	dobin noad showindex
#	use imagemagick && dobin markpics

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
	elog "up from this version, noad works with .ts file structur"
	elog "used in comming up version >=vdr-1.7.4"
}
