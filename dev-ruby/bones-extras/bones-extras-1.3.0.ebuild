# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/bones-extras/bones-extras-1.3.0.ebuild,v 1.1 2010/10/29 15:26:39 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

# no tests
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="doc:rdoc"
RUBY_FAKEGME_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="The extras package for Mr Bones"
HOMEPAGE="http://github.com/TwP/${PN}"

IUSE=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_rdepend ">=dev-ruby/bones-3.5.0"
