# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gnuplot/gnuplot-2.2.ebuild,v 1.2 2009/08/22 20:48:06 graaff Exp $

inherit gems

USE_RUBY="ruby18 ruby19"
DESCRIPTION="Gnuplot drawing library - Ruby Bindings"
HOMEPAGE="http://rgplot.rubyforge.org/"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="sci-visualization/gnuplot"
