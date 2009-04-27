# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/flickr/flickr-1.0.2-r1.ebuild,v 1.1 2009/04/27 12:33:50 flameeyes Exp $

inherit ruby eutils

DESCRIPTION="An insanely easy interface to the Flickr photo-sharing service."
HOMEPAGE="http://rubyforge.org/projects/flickr/"
SRC_URI="mirror://gentoo/${P}-gentoo.tar.bz2"

S="${WORKDIR}/${P}-gentoo"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test doc"

# Tests fail for now, they don't seem to be designed to work just yet
RESTRICT="test"

RDEPEND="dev-ruby/xml-simple"
DEPEND="
	test? ( dev-ruby/rake
		dev-ruby/rubygems )
	doc? ( dev-ruby/rake
		dev-ruby/rubygems )"

USE_RUBY="ruby18"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-fix.patch"
}

src_compile() {
	if use doc; then
		rake rdoc || die "rake rdoc failed"
	fi
}

src_install() {
	cd "${S}"/lib
	doruby -r * || die "doruby failed"

	if use doc; then
		dohtml -r "${S}"/doc/* || die "dohtml failed"
	fi

	dohtml "${S}"/index.html || die "dohtml failed"

	insinto $(${RUBY} -r rbconfig -e 'print Config::CONFIG["vendorlibdir"]' | sed -e 's:vendor_ruby:gems:')/specifications
	doins "${S}"/${P}.gemspec || die "Unable to install fake gemspec"
}
