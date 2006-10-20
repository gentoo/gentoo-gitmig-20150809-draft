# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rmagick/rmagick-1.9.3-r1.ebuild,v 1.7 2006/10/20 21:19:42 agriffis Exp $

inherit ruby

#
# The gem for this package doesn't seem to play well with portage.  It runs a GNUish configure script, with argument
# passed directly from the gem install command, but gem install doesn't use the same style of arguments.  Thus, unless
# you're smart enough to come up with a fix, please leave this as a source package install.
#

DESCRIPTION="An interface between Ruby and the ImageMagick(TM) image processing library"
HOMEPAGE="http://rmagick.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/6499/RMagick-${PV}.tar.bz2"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 hppa ia64 ppc sparc x86"
IUSE=""
DEPEND="virtual/ruby
	>=media-gfx/imagemagick-6.0"

S=${WORKDIR}/RMagick-${PV}
