# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rubyripper/rubyripper-0.4.4.ebuild,v 1.1 2007/12/14 18:03:10 flameeyes Exp $
EAPI="1"

inherit ruby

DESCRIPTION="a secure audio ripper for linux"
HOMEPAGE="http://code.google.com/p/rubyripper"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="flac mp3 vorbis +gtk cli"

ILINGUAS="de hu nl ru"

for lingua in $ILINGUAS; do
	IUSE="${IUSE} linguas_${lingua}"
done

DEPEND=""
RDEPEND="gtk? ( dev-ruby/ruby-gtk2 )
	dev-ruby/ruby-gettext
	virtual/eject
	media-sound/cd-discid
	media-sound/cdparanoia
	flac? ( media-libs/flac )
	mp3? ( media-sound/lame )
	vorbis? ( media-sound/vorbis-tools )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-iconinstall.patch"
	epatch "${FILESDIR}/${P}-desktopfile.patch"
	epatch "${FILESDIR}/${P}-editor-environment.patch"
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

	./configure ${myconf} || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
