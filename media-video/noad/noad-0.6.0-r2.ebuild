# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/noad/noad-0.6.0-r2.ebuild,v 1.6 2007/01/05 17:18:22 hd_brummy Exp $

inherit eutils

DESCRIPTION="Mark commercial Breaks in VDR records"
HOMEPAGE="http://www.freepgs.com/noad/"
SRC_URI="http://www.freepgs.com/${PN}/${P}.tar.bz2
		mirror://vdrfiles/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="ffmpeg imagemagick"

DEPEND="media-libs/libmpeg2
	media-video/vdr
	ffmpeg? ( >=media-video/ffmpeg-0.4.8 )
	imagemagick? ( >=media-gfx/imagemagick-6.2.4.2-r1 )"

src_unpack() {

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-directoryfix.diff

	sed -i -e "s:-g -O3:$CXXFLAGS:" configure
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

	if has_version ">=media-tv/gentoo-vdr-scripts-0.1_alpha8"
	then
		insinto /etc/conf.d
		doins ${FILESDIR}/vdraddon.noad

		insinto /usr/lib/vdr/record
		doins ${FILESDIR}/record-20-noad.sh

		insinto /etc/vdr/reccmds
		doins ${FILESDIR}/reccmds.noad.conf
	fi
}

pkg_postinst() {

	echo
	elog "Congratulations, you have just installed noad!,"
	elog "To integrate noad in VDR you should do this:"
	echo
	if has_version ">=media-tv/gentoo-vdr-scripts-0.1_alpha8"
	then
		elog "start and set Parameter in /etc/conf.d/vdraddon.noad"
	else
		elog "Add in /etc/conf.d/vdr:"
		echo
		elog "RECORD=\"noad nice --statisticfile=/video/noad.stat\" "
	fi
	echo
	elog "More infos can be found on vdr.gentoo.de"
	echo
	elog "Note: You can use here all pararmeters for noad,"
	elog "please look in the documentation of noad."
	echo
}
