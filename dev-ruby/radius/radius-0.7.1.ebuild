# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/radius/radius-0.7.1.ebuild,v 1.1 2011/08/15 06:11:06 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG QUICKSTART.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Powerful tag-based template system."
HOMEPAGE="http://radius.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/redcloth )"
