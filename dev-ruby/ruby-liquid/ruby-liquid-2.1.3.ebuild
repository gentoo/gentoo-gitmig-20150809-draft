# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-liquid/ruby-liquid-2.1.3.ebuild,v 1.1 2010/08/09 05:33:31 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

# Drop tests and documentation tasks for 2.1.2 since they are no
# longer included in the gem, and github is not tagged and it's not
# obvious how it matches the released gem version.
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG History.txt README.txt"

RUBY_FAKEGEM_NAME="liquid"

inherit ruby-fakegem

DESCRIPTION="Template engine for Ruby"
HOMEPAGE="http://www.liquidmarkup.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86-fbsd ~x86"
IUSE=""
