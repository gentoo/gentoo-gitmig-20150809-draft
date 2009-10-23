# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-liquid/ruby-liquid-2.0.0.ebuild,v 1.2 2009/10/23 15:41:50 mr_bones_ Exp $

inherit gems

MY_P="${P/ruby-/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Template engine for Ruby"
HOMEPAGE="http://www.liquidmarkup.org/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86-fbsd ~x86"
IUSE=""

USE_RUBY="ruby18 ruby19"
