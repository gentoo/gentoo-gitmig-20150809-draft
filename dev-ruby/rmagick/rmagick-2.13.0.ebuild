# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rmagick/rmagick-2.13.0.ebuild,v 1.1 2009/12/28 11:16:03 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng

# The gem for this package doesn't seem to play well with portage.  It
# runs a GNUish configure script, with argument passed directly from
# the gem install command, but gem install doesn't use the same style
# of arguments.  Thus, unless you're smart enough to come up with a
# fix, please leave this as a source package install.

MY_PV=${PV//_/-}

DESCRIPTION="An interface between Ruby and the ImageMagick(TM) image processing library"
HOMEPAGE="http://rmagick.rubyforge.org/"
SRC_URI="mirror://rubyforge/rmagick/RMagick-${MY_PV}.tar.bz2"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples doc"

# hdri causes extensive changes in the imagemagick internals, and
# rmagick is not ready to deal with those, see bug 184356.
RDEPEND=">=media-gfx/imagemagick-6.3.5.10[-hdri]"
DEPEND="${RDEPEND}
	doc? ( app-text/ghostscript-gpl media-libs/libwmf )"

S="${WORKDIR}/RMagick-${PV}"

each_ruby_configure() {
	local myconf

	# When documentation is built many examples are also run. Not all
	# of them may work (e.g. due to missing additional dependencies)
	# so we allow the examples to fail.
	if ! use doc ; then
		myconf="--disable-htmldoc --allow-example-errors"
		myconf="${myconf} --doc-dir=${D}/usr/share/doc/${P}/html"
	fi

	${RUBY} setup.rb config --prefix="${D}/usr" "$@" \
		${myconf} || die "setup.rb config failed"
}

each_ruby_compile() {
	${RUBY} setup.rb setup || die "setup.rb setup failed"
}

each_ruby_install() {
	${RUBY} setup.rb install --prefix="${D}" || die "setup.rb install failed"
}

all_ruby_install() {
	dodoc ChangeLog README.html README-Mac-OSX.txt || die

	use examples && dodoc examples/*
}
