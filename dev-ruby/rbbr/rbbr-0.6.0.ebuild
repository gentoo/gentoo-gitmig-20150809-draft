# Copyright 1999-2004 Gentoo Technologies, Inc.; acid DOT punk AT gmx DOT net
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rbbr/rbbr-0.6.0.ebuild,v 1.3 2004/04/24 17:58:54 usata Exp $

DESCRIPTION="Ruby Browser for modules/classes hierarchy and their constants and methods"
HOMEPAGE="http://ruby-gnome2.sourceforge.jp/hiki.cgi?rbbr"
SRC_URI="mirror://sourceforge/ruby-gnome2/${P}-withapi.tar.gz"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="Ruby"
IUSE="nls cjk"

DEPEND="|| ( >=dev-lang/ruby-1.8.0 dev-lang/ruby-cvs )
	 >=dev-ruby/ruby-gnome2-0.7.0
	 >=dev-ruby/ri-0.8a
	 nls? ( >=dev-ruby/ruby-gettext-0.5.3 )
	 cjk? ( >=dev-ruby/refe-0.7.2 )"

S="${WORKDIR}/${P}-withapi"

src_compile() {
	ruby install.rb config || die "install.rb config failed"
	ruby install.rb setup || die "install.rb setup failed"
}

src_install() {
	ruby install.rb install --prefix=${D} || die "install.rb install failed"
	dosed "/LIB_DIR/s%/[0-9]\.[0-9]%%" /usr/lib/ruby/site_ruby/*/rbbr/config.rb
}
