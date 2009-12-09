# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gruff/gruff-0.3.6.ebuild,v 1.3 2009/12/09 21:20:16 maekke Exp $

EAPI="2"

inherit gems

DESCRIPTION="A ruby library for creating pretty graphs and charts"
HOMEPAGE="http://rubyforge.org/projects/gruff/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ia64 x86"
IUSE=""
USE_RUBY="ruby18"

DEPEND="dev-ruby/rmagick
	media-gfx/imagemagick[truetype]"
RDEPEND="${DEPEND}"
