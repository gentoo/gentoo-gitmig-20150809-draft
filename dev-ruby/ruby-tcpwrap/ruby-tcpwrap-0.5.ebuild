# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-tcpwrap/ruby-tcpwrap-0.5.ebuild,v 1.1 2003/05/13 14:33:19 twp Exp $

DESCRIPTION="A TCP wrappers library for Ruby"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=ruby-tcpwrap"
SRC_URI="http://shugo.net/archive/ruby-tcpwrap/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~sparc ~x86"
DEPEND="dev-lang/ruby
	net-libs/libident
	sys-apps/tcp-wrappers"
S=${WORKDIR}/${PN}

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	einstall
	dodoc README*
	insinto /usr/share/doc/${PF}/html
	doins doc/*
}
