# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/columnize/columnize-0.3.1-r2.ebuild,v 1.2 2010/10/25 02:03:27 jer Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_EXTRADOC="AUTHORS ChangeLog NEWS README"

inherit ruby-fakegem

DESCRIPTION="Sorts an array in column order."
HOMEPAGE="http://rubyforge.org/projects/rocky-hacks/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE=""

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"
