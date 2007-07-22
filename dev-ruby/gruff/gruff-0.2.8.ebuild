# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gruff/gruff-0.2.8.ebuild,v 1.3 2007/07/22 16:50:19 graaff Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A ruby library for creating pretty graphs and charts"
HOMEPAGE="http://rubyforge.org/projects/gruff/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ia64 ~x86 ~amd64"
IUSE=""
RESTRICT="test"

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/hoe-1.1.2
	dev-ruby/rmagick"

pkg_setup() {
	if ! built_with_use media-gfx/imagemagick truetype ; then
		eerror "media-gfx/imagemagick must be built with the truetype USE flag"
		eerror "in order for gruff to create graphics with text."
		eerror "Please re-emerge imagemagick with the truetype USE flag enabled."
		die "imagemagick does not have the truetype USE flag enabled"
	fi
}
