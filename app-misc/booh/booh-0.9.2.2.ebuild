# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/booh/booh-0.9.2.2.ebuild,v 1.4 2010/06/01 19:24:11 graaff Exp $

EAPI="2"

inherit eutils bash-completion

DESCRIPTION="Static HTML photo album generator"
HOMEPAGE="http://booh.org/index.html"
SRC_URI="http://booh.org/packages/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk encode exif"

DEPEND="dev-lang/ruby
	>=dev-ruby/ruby-gettext-0.8.0
	media-gfx/exiv2
	dev-ruby/ruby-glib2
	gtk? (	>=dev-ruby/ruby-gtk2-0.12
		>=x11-libs/gtk+-2.8 )"

RDEPEND="${DEPEND}
	dev-ruby/rubygems
	|| ( media-gfx/imagemagick[jpeg,png] media-gfx/graphicsmagick[jpeg,png] )
	exif? ( media-gfx/exif )
	encode? ( media-video/mplayer )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.9.1-require_gems.patch
	epatch "${FILESDIR}"/${P}-stdc.patch

	# Remove scripts requiring gtk if gtk is not used
	if ! use gtk; then
		rm bin/booh bin/booh-classifier bin/booh-fix-whitebalance \
		bin/booh-gamma-correction
	fi
}

src_configure() {
	ruby setup.rb config || die "ruby setup.rb config failed"
	ruby setup.rb setup || die "ruby setup.rb setup failed"
	cd ext
	ruby extconf.rb || die "ruby extconf.rb failed"
	sed -i -e 's:-Wl,--no-undefined ::' Makefile || die "--no-undefined removal failed"
	sed -i -e 's:-Wl,-R$(libdir)::' -e 's:-Wl,-R -Wl,$(libdir)::' Makefile || die "Fix insecure RUNPATH failed"
}

src_install() {
	ruby setup.rb install \
		--prefix="${D}" || die "ruby setup.rb install failed"
	cd ext
	emake install \
		DESTDIR=${D} \
		libdir=${D}/`ruby -rrbconfig -e "puts Config::CONFIG['sitelibdir']"` \
		archdir=${D}/`ruby -rrbconfig -e "puts Config::CONFIG['sitearchdir']"` \
		|| die "emake install failed"
	cd ..
	domenu desktop/booh-classifier.desktop desktop/booh.desktop || die "domenu failed"
	doicon desktop/booh-48x48.png || die "doicon failed"
	dobashcompletion booh.bash-completion || die "dobashcompletion failed"
	dodoc AUTHORS ChangeLog INTERNALS README VERSION THEMES \
		|| die "dodoc failed"
}
