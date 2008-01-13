# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lash/lash-0.5.4.ebuild,v 1.2 2008/01/13 14:32:56 aballier Exp $

inherit eutils libtool

DESCRIPTION="LASH Audio Session Handler"
HOMEPAGE="http://www.nongnu.org/lash/"
SRC_URI="http://download.savannah.gnu.org/releases/lash/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa debug gtk python"

RDEPEND="alsa? ( media-libs/alsa-lib )
	media-sound/jack-audio-connection-kit
	dev-libs/libxml2
	gtk? ( >=x11-libs/gtk+-2.0 )
	python? ( dev-lang/python )
	|| ( sys-libs/readline sys-libs/libedit )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if use alsa && ! built_with_use --missing true media-libs/alsa-lib midi; then
		eerror ""
		eerror "To be able to build ${CATEGORY}/${PN} with ALSA support you"
		eerror "need to have built media-libs/alsa-lib with midi USE flag."
		die "Missing midi USE flag on media-libs/alsa-lib"
	fi
}

src_unpack() {
	unpack ${A}
	elibtoolize
}

src_compile() {
	local myconf

	# Yet-another-broken-configure: --enable-pylash would disable it.
	use python || myconf="${myconf} --disable-pylash"

	econf \
		$(use_enable alsa alsa-midi) \
		$(use_enable gtk gtk2) \
		$(use_enable debug) \
		${myconf} \
		--disable-dependency-tracking \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README TODO
}
