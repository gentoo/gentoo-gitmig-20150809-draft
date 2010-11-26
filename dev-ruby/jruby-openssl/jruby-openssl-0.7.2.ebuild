# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/jruby-openssl/jruby-openssl-0.7.2.ebuild,v 1.1 2010/11/26 12:22:09 graaff Exp $

EAPI=2

USE_RUBY=jruby

RUBY_FAKEGEM_TASK_DOC="redocs"
RUBY_FAKEGEM_DOCDIR="doc"

# Seems like the PKCS7 support requires the BouncyCastle JARs that are
# shipped but somewhat fails; unfortunately, this package does not
# provide the source files, so we cannot really rebuild this.
RESTRICT=test

RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="A Ruby SSL library that works with JRuby"
HOMEPAGE="http://rubyforge.org/projects/jruby-extras"

LICENSE="MIT || ( CPL-1.0 GPL-2	LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

ruby_add_bdepend doc dev-ruby/hoe
#ruby_add_bdepend "test? ( dev-ruby/hoe dev-ruby/mocha )"
