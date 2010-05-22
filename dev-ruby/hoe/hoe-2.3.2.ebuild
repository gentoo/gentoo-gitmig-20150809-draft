# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hoe/hoe-2.3.2.ebuild,v 1.7 2010/05/22 14:23:12 flameeyes Exp $

inherit gems

USE_RUBY="ruby18"

DESCRIPTION="Hoe extends rake to provide full project automation."
HOMEPAGE="http://seattlerb.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-ruby/rake-0.8.7
	>=dev-ruby/rubyforge-1.0.3"
RDEPEND="${DEPEND}"
