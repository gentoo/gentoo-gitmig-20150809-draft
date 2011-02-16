# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/radius/radius-0.6.1-r1.ebuild,v 1.2 2011/02/16 07:12:39 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG QUICKSTART.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Powerful tag-based template system."
HOMEPAGE="http://radius.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# Remove newgem related tasks to avoid dependency on it. This is only
# needed to create and distribute the gem.
all_ruby_prepare() {
	sed -i -e '/newgem\/tasks/d' Rakefile || die "Unable to remove newgem code."
	sed -i -e 's/newgem//' Rakefile || die "Unable to remove newgem code."
	sed -i -e 's/::Newgem::VERSION/0/' Rakefile || die "Unable to remove newgem code."
}

ruby_add_bdepend "dev-ruby/hoe dev-ruby/rubigen"
