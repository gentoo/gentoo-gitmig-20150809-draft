# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrdao/cdrdao-1.2.3-r1.ebuild,v 1.1 2010/07/16 15:50:08 ssuominen Exp $

EAPI=2

DESCRIPTION="Burn CDs in disk-at-once mode -- with optional GUI frontend"
HOMEPAGE="http://cdrdao.sourceforge.net/"
if [[ ${PV/*_rc*} ]]
then
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
else
	SRC_URI="http://www.poolshark.org/src/${P/_}.tar.bz2"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="gcdmaster encode pccts mad vorbis"

RDEPEND="virtual/cdrtools
	encode? ( >=media-sound/lame-3.90 )
	gcdmaster? ( dev-libs/libsigc++:2
		>=dev-cpp/gtkmm-2.4
		>=dev-cpp/libgnomeuimm-2.6
		media-libs/libao )
	mad? ( media-libs/libmad
		media-libs/libao )
	vorbis? ( media-libs/libvorbis
		media-libs/libao )
	!app-cdr/cue2toc"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	pccts? ( >=dev-util/pccts-1.33.24-r1 )"

S=${WORKDIR}/${P/_}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_with gcdmaster xdao) \
		$(use_with vorbis ogg-support) \
		$(use_with mad mp3-support) \
		$(use_with encode lame)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog CREDITS NEWS README{,.PlexDAE}
}
