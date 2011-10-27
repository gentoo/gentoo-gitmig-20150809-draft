# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/snmplib/snmplib-1.0.4.ebuild,v 1.1 2011/10/27 06:09:07 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_NAME="snmp"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.rdoc"
RUBY_FAKEGEM_EXTRAINSTALL="data"

inherit ruby-fakegem

IUSE=""

DESCRIPTION="SNMP library implemented in pure Ruby"
HOMEPAGE="http://snmplib.rubyforge.org/"

KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
LICENSE="Ruby"
SLOT="0"

all_ruby_prepare() {
	# Use the fully qualified class name to avoid problems with other
	# Integer class definitions. Should fix
	# https://bugs.gentoo.org/show_bug.cgi?id=323423
	sed -i -e 's/\sInteger/ SNMP::Integer/' test/* || die
}

each_ruby_test() {
	${RUBY} -Ilib -S testrb test/test_*.rb || die
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}
	doins -r examples
}
