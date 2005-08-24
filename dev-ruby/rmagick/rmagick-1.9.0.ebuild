# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rmagick/rmagick-1.9.0.ebuild,v 1.1 2005/08/24 16:15:53 tigger Exp $

inherit ruby gems

DESCRIPTION="An interface between Ruby and the ImageMagick(TM) image processing library"
HOMEPAGE="http://rmagick.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86 ~amd64"
IUSE=""
DEPEND="virtual/ruby
	>=media-gfx/imagemagick-5.5.1"
