# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mysql-ruby/mysql-ruby-2.9.0.ebuild,v 1.1 2012/12/25 08:19:23 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_NAME="mysql"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="A Ruby extension library to use MySQL"
HOMEPAGE="http://www.tmtm.org/en/mysql/ruby/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="test"

DEPEND="virtual/mysql[-static]"
RDEPEND="${DEPEND}"

TEST_DIR="/usr/share/${PN}/test/"

#all_ruby_prepare() {
#	epatch "${FILESDIR}/${P}-test2.patch"
#}

each_ruby_configure() {
	${RUBY} -Cext/mysql_api extconf.rb --with-mysql-config "${EPREFIX}/usr/bin/mysqlconfig" || die
}

each_ruby_compile() {
	emake -Cext/mysql_api || die
}

all_ruby_install() {
	all_fakegem_install
}
