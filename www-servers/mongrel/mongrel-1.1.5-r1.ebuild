# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/mongrel/mongrel-1.1.5-r1.ebuild,v 1.1 2010/01/23 14:13:57 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG README TODO"

inherit ruby-fakegem

DESCRIPTION="A small fast HTTP library and server that runs Rails, Camping, and Nitro apps"
HOMEPAGE="http://mongrel.rubyforge.org/"

LICENSE="|| ( mongrel GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend ">=dev-ruby/daemons-1.0.3
	>=dev-ruby/gem_plugin-0.2.3
	>=dev-ruby/fastthread-1.0.1"
