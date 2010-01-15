# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/portaudio/portaudio-19_pre20090514.ebuild,v 1.2 2010/01/15 09:45:59 fauli Exp $

EAPI=2

inherit libtool

MY_P=pa_stable_v${PV/pre}

DESCRIPTION="An open-source cross platform audio API."
HOMEPAGE="http://www.portaudio.com"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~ppc-macos"
IUSE="alsa +cxx debug jack oss"

RDEPEND="alsa? ( media-libs/alsa-lib )
	jack? ( >=media-sound/jack-audio-connection-kit-0.109.2-r1 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_prepare() {
	elibtoolize
}

src_configure() {
	econf $(use_enable cxx) $(use_with jack) $(use_with alsa) \
		$(use_with oss) $(use_with debug debug-output)
}

src_compile() {
	emake lib/libportaudio.la || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc README.txt
	dohtml index.html
}
