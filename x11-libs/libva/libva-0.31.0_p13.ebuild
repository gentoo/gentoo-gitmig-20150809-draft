# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libva/libva-0.31.0_p13.ebuild,v 1.1 2010/05/11 09:16:46 aballier Exp $

EAPI="2"
inherit eutils autotools

PLEVEL=${PV##*_p}
MY_PV=${PV/_p*}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Video Acceleration (VA) API for Linux"
HOMEPAGE="http://www.splitted-desktop.com/~gbeauchesne/libva/"
SRC_URI="http://www.splitted-desktop.com/~gbeauchesne/${PN}/${PN}_${MY_PV}-1+sds${PLEVEL}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="opengl"

VIDEO_CARDS="dummy" # intel, nvidia
for x in ${VIDEO_CARDS}; do
	IUSE+=" video_cards_${x}"
done

RDEPEND=">=x11-libs/libdrm-2.4
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXfixes
	opengl? ( virtual/opengl )"
# nvidia ? ( x11-libs/vdpau-video )

DEPEND="${RDEPEND}
	dev-util/pkgconfig"
# video_cards_intel? gen4asm

S=${WORKDIR}/${MY_P}

src_prepare() {
	EPATCH_SOURCE="${S}/debian/patches" EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" EPATCH_OPTS="-g0 -E --no-backup-if-mismatch -p1" epatch
	epatch "${FILESDIR}"/libva-dont-install-tests.patch
	eautoreconf
}

src_configure() {
	econf \
	$(use_enable video_cards_dummy dummy-driver) \
	--disable-i965-driver \
	$(use_enable opengl glx)
	# $(use_enable video_cards_intel i965-driver): someone please test it and
	# add the missing bits
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	find "${D}" -name '*.la' -delete
}
