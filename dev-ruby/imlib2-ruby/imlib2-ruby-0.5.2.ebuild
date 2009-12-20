# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/imlib2-ruby/imlib2-ruby-0.5.2.ebuild,v 1.2 2009/12/20 13:33:23 graaff Exp $

inherit ruby gems

DESCRIPTION="Imlib2 bindings for Ruby, written with the help of these people."
HOMEPAGE="http://www.pablotron.org/software/imlib2-ruby/"
SRC_URI="http://www.pablotron.org/files/gems/${P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-libs/imlib2-1.2.0"
RDEPEND="${DEPEND}"
USE_RUBY="ruby18"
