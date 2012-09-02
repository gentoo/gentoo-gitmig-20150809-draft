# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/jwt/jwt-0.1.5.ebuild,v 1.1 2012/09/02 07:56:42 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="A Ruby implementation of JSON Web Token draft 06."
HOMEPAGE="https://github.com/progrium/ruby-jwt"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
