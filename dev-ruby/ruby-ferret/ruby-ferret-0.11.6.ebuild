# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-ferret/ruby-ferret-0.11.6.ebuild,v 1.2 2010/05/22 15:46:43 flameeyes Exp $

inherit ruby gems

MY_P="${P/ruby-/}"
DESCRIPTION="A ruby indexing/searching library"
HOMEPAGE="http://ferret.davebalmain.com/trac/"
SRC_URI="mirror://rubygems/${MY_P}.gem"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-ruby/rake"
