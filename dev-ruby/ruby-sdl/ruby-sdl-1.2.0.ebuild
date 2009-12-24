# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-sdl/ruby-sdl-1.2.0.ebuild,v 1.4 2009/12/24 17:10:22 graaff Exp $

inherit eutils

MY_P="${P/-/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Ruby/SDL: Ruby bindings for SDL"
HOMEPAGE="http://www.kmc.gr.jp/~ohai/rubysdl.en.html"
SRC_URI="http://www.kmc.gr.jp/~ohai/rubysdl/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc x86"

# Optional libraries, not in Portage as of writing:
#	SGE -- ebuild submitted, not yet in portage CVS
#	SDLSKK	--	http://www.kmc.gr.jp/~ohai/

# local USE flags "image mixer sge"
IUSE="image mixer truetype mpeg"

RDEPEND="dev-lang/ruby
	>=media-libs/libsdl-1.2.5
	truetype? ( >=media-libs/sdl-ttf-2.0.6 )
	image? ( >=media-libs/sdl-image-1.2.2 )
	mixer? ( >=media-libs/sdl-mixer-1.2.4 )
	mpeg? ( >=media-libs/smpeg-0.4.4-r1 )"
#	sge? ( >=media-libs/sge )

src_compile() {
	ruby extconf.rb || die "extconf.rb failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "einstall failed"

	dodoc rubysdl_const_list.txt README.en
	insinto /usr/share/doc/${P}
	doins rubysdl_doc.en.rd
	insinto /usr/share/doc/${P}/sample
	doins sample/*
}

pkg_postinst () {
	if ! use image || ! use mixer || ! use truetype || ! use mpeg ; then
		echo ""
		ewarn "If any of the following packages are not installed, Ruby/SDL"
		ewarn "will be missing some functionality. This is ok, but may"
		ewarn "cause errors in Ruby/SDL programs that need these libraries:"
		ewarn ""
		ewarn "\tmedia-libs/sdl-image\tImage loading (PNG, JPEG, etc.)"
		ewarn "\tmedia-libs/sdl-mixer\tSound mixing"
		ewarn "\tmedia-libs/sdl-ttf\tTrueType Fonts"
		#ewarn "\tmedia-libs/sge\t\tVarious cool graphics extensions"
		ewarn "\tmedia-libs/smpeg\tMPEG playback (including mp3)"
		ewarn ""
		ewarn "If you need the functionality offered by these libraries,"
		ewarn "emerge the desired libraries, then re-emerge dev-ruby/rubysdl"
		echo ""
	fi
}
