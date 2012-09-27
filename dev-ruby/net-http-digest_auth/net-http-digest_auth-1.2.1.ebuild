# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-http-digest_auth/net-http-digest_auth-1.2.1.ebuild,v 1.2 2012/09/27 10:32:54 ssuominen Exp $

EAPI=4

USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="An implementation of RFC 2617 - Digest Access Authentication."
HOMEPAGE="http://github.com/drbrain/net-http-digest_auth"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64"
IUSE="test"

ruby_add_bdepend "test? ( dev-ruby/hoe dev-ruby/minitest )"
