# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/piston/piston-2.0.7.ebuild,v 1.1 2009/12/02 06:52:20 graaff Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A Rails utility that uses Subversion to manage local copies of upstream vendor branches."
HOMEPAGE="http://piston.rubyforge.org"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=" >=dev-ruby/log4r-1.0.5
	>=dev-ruby/main-2.8.3
	>=dev-ruby/activesupport-2.0.0"
DEPEND="${RDEPEND}"
