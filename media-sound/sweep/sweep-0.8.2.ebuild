# Copyright 2002 Paul Thompson
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sweep/sweep-0.8.2.ebuild,v 1.1 2003/05/09 16:23:38 darkspecter Exp $

IUSE="oggvorbis alsa nls"

DESCRIPTION="Sweep is an audio editor and live playback tool"
HOMEPAGE="http://www.metadecks.org/software/sweep/"
SRC_URI="http://www.metadecks.org/software/sweep/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~mips ~alpha"

DEPEND=">=media-libs/libsndfile-1.0*
		>=x11-libs/gtk+-1.2*
		dev-libs/tdb
		media-libs/libsamplerate
		media-sound/mad
		media-libs/speex
		( oggvorbis? media-libs/libogg
					 media-libs/libvorbis )
		alsa? ( media-libs/alsa-lib )
		nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

#pkg_setup() {
#	if [ "`use alsa`" -a "${FORCE_ALSA}" != "yes" ]
#	then
#		einfo "you have alsa in USE, which is curently broken in sweep !"
#		die "to force the use of alsa use FORCE_ALSA=\"yes\" emerge sweep"
#	fi
#}

src_compile() {
	local myconf
	use oggvorbis || myconf="${myconf} --disable-oggvorbis"
	use alsa && myconf="${myconf} --enable-alsa"
	use nls  || myconf="${myconf} --disable-nls"

	use experimental && myconf="${myconf} --enable-experimental"

	econf ${myconf}
	emake
}

src_install() {
	einstall
}

pkg_postinst() {
	einfo "To enable the experimental code in sweep merge it"
	einfo "with \"experimantal\" in USE."
	einfo ""
	einfo "Sweep can use ladspa plugins,"
	einfo "emerge ladspa-sdk and ladspa-cmt if you want them."
}
