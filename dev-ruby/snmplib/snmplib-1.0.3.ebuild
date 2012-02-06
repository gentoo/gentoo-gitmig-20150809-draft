# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/snmplib/snmplib-1.0.3.ebuild,v 1.8 2012/02/06 19:15:15 ranger Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_NAME="snmp"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README"
RUBY_FAKEGEM_EXTRAINSTALL="data"

inherit ruby-fakegem

IUSE=""

DESCRIPTION="SNMP library implemented in pure Ruby"
HOMEPAGE="http://snmplib.rubyforge.org/"

KEYWORDS="amd64 ia64 ppc x86"
LICENSE="Ruby"
SLOT="0"

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

all_ruby_prepare() {
	# Use the fully qualified class name to avoid problems with other
	# Integer class definitions. Should fix
	# https://bugs.gentoo.org/show_bug.cgi?id=323423
	sed -i -e 's/\sInteger/ SNMP::Integer/' test/* || die
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}
	doins -r examples
}
