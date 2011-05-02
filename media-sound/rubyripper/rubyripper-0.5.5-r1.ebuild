# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rubyripper/rubyripper-0.5.5-r1.ebuild,v 1.7 2011/05/02 21:24:52 billie Exp $

EAPI=2
VIRTUALX_REQUIRED="always"
inherit ruby virtualx

DESCRIPTION="A secure audio ripper for Linux"
HOMEPAGE="http://code.google.com/p/rubyripper"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE="cli flac +gtk +mp3 normalize +vorbis wav"

ILINGUAS="de es fr hu nl ru"

for lingua in $ILINGUAS; do
	IUSE="${IUSE} linguas_${lingua}"
done

RDEPEND="gtk? ( dev-ruby/ruby-gtk2 )
	dev-ruby/ruby-gettext
	virtual/eject
	media-sound/cd-discid
	media-sound/cdparanoia
	flac? ( media-libs/flac )
	mp3? ( media-sound/lame )
	vorbis? ( media-sound/vorbis-tools )
	normalize? ( media-sound/normalize
		mp3? ( media-sound/mp3gain )
		vorbis? ( media-sound/vorbisgain )
		wav? ( media-sound/wavegain ) )"
DEPEND="${RDEPEND}"

src_prepare() {
	# fix for bug 203737
	epatch "${FILESDIR}"/${PN}-0.5.2-require-rubygems.patch
}

src_configure() {
	local myconf="--prefix=/usr"
	local enable_linguas=""

	for lingua in $ILINGUAS; do
		use linguas_$lingua && enable_linguas="${enable_linguas},${lingua}"
	done

	[[ -n ${enable_linguas} ]] && myconf="${myconf} --enable-lang=${enable_linguas#,}"

	use gtk && myconf="${myconf} --enable-gtk2"
	use cli && myconf="${myconf} --enable-cli"

	Xeconf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
