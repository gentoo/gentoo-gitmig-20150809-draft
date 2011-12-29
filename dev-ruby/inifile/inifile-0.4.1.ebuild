# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/inifile/inifile-0.4.1.ebuild,v 1.1 2011/12/29 00:48:37 flameeyes Exp $

EAPI="4"

USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_TASK_TEST="test"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.txt History.txt"

inherit ruby-fakegem eutils

DESCRIPTION="Native Ruby package for reading and writing INI files."
HOMEPAGE="http://github.com/jtrupiano/timecop"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "
	doc? ( dev-ruby/bones )
	test? ( dev-ruby/bones )
"
