# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-ferret/ruby-ferret-0.11.4.ebuild,v 1.3 2008/01/16 23:29:40 rbrown Exp $

inherit ruby gems

MY_P="${P/ruby-/}"
DESCRIPTION="A ruby indexing/searching library"
HOMEPAGE="http://ferret.davebalmain.com/trac/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-ruby/rake"
