# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/jquery-rails/jquery-rails-1.0.9.ebuild,v 1.1 2011/05/29 09:59:24 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

RUBY_FAKEGEM_EXTRAINSTALL="vendor"

inherit ruby-fakegem

DESCRIPTION="jQuery! For Rails! So great."
HOMEPAGE="http://www.rubyonrails.org"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

ruby_add_rdepend "dev-ruby/railties:3.0 >=dev-ruby/thor-0.14"
