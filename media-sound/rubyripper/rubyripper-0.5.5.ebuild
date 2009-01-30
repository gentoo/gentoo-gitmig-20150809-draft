# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rubyripper/rubyripper-0.5.5.ebuild,v 1.1 2009/01/30 20:00:28 yngwin Exp $

EAPI="1"

inherit ruby virtualx

DESCRIPTION="A secure audio ripper for Linux"
HOMEPAGE="http://code.google.com/p/rubyripper"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="cli flac +gtk +mp3 normalize +vorbis wav"
ILINGUAS="de es hu nl ru"

for lingua in $ILINGUAS; do
	IUSE="${IUSE} linguas_${lingua}"
done

DEPEND="dev-ruby/ruby-gettext"
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

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix for bug 203737
	epatch "${FILESDIR}/${PN}-0.5.2-require-rubygems.patch"
}

src_compile() {
	local myconf="--prefix=/usr"
	local enable_linguas=""

	for lingua in $ILINGUAS; do
		use linguas_$lingua && enable_linguas="${enable_linguas},${lingua}"
	done

	[[ -n ${enable_linguas} ]] && myconf="${myconf} --enable-lang=${enable_linguas#,}"

	use gtk && myconf="${myconf} --enable-gtk2"
	use cli && myconf="${myconf} --enable-cli"

	Xeconf ${myconf} || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
