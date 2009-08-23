# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gruff/gruff-0.3.6.ebuild,v 1.1 2009/08/23 07:50:17 graaff Exp $

EAPI="2"

inherit gems

DESCRIPTION="A ruby library for creating pretty graphs and charts"
HOMEPAGE="http://rubyforge.org/projects/gruff/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ia64 ~x86 ~amd64"
IUSE=""
USE_RUBY="ruby18"

DEPEND="dev-ruby/rmagick
	media-gfx/imagemagick[truetype]"
RDEPEND="${DEPEND}"
