# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-patch-bay/alsa-patch-bay-1.0.0-r2.ebuild,v 1.1 2004/11/22 22:30:48 eradicator Exp $

IUSE="alsa jack ladcca fltk gtk"

inherit eutils

DESCRIPTION="Graphical patch bay for the ALSA sequencer API."
HOMEPAGE="http://pkl.net/~node/alsa-patch-bay.html"
SRC_URI="http://pkl.net/~node/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="gtk? ( =dev-cpp/gtkmm-2.2* )
	fltk? ( >=x11-libs/fltk-1.1.2 )
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc1 )
	jack? ( media-sound/jack-audio-connection-kit )
	ladcca? ( media-libs/ladcca )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-amd64.patch
}

src_compile() {
	econf $(use_enable fltk) $(use_enable gtk gtkmm) $(use_enable jack) \
	      $(use_enable alsa) $(use_enable jack) || die
	emake || die
}

src_install() {
	# needs patching: make DESTDIR="${D}" APB_DESKTOP_PREFIX=/usr/share install || die
	einstall APB_DESKTOP_PREFIX=${D}/usr/share || die
	dodoc AUTHORS NEWS README THANKS TODO
}

pkg_preinst() {
	if [ -e ${D}/usr/bin/jack-patch-bay ]
	then
		rm ${D}/usr/bin/jack-patch-bay
		ln -s alsa-patch-bay ${D}/usr/bin/jack-patch-bay
	fi
}
