# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/cerberus/cerberus-0.7.ebuild,v 1.1 2009/08/08 16:04:06 graaff Exp $

inherit gems

USE_RUBY="ruby18"
DESCRIPTION="Continuous Integration tool for ruby projects"
HOMEPAGE="http://rubyforge.org/projects/cerberus"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="
	>=dev-ruby/actionmailer-1.3.3
	>=dev-ruby/activesupport-1.4.2
	>=dev-ruby/rake-0.7.3"
RDEPEND="${DEPEND}"
