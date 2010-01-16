# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-liquid/ruby-liquid-2.0.0-r1.ebuild,v 1.1 2010/01/16 19:18:22 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG History.txt README.txt"

inherit ruby-fakegem

MY_P="${P/ruby-/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Template engine for Ruby"
HOMEPAGE="http://www.liquidmarkup.org/"
SRC_URI="mirror://rubygems/${MY_P}.gem"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86-fbsd ~x86"
IUSE=""

ruby_add_bdepend doc dev-ruby/hoe
ruby_add_bdepend test dev-ruby/hoe
