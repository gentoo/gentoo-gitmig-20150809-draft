# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rbbr/rbbr-0.6.0.ebuild,v 1.15 2012/05/01 18:24:04 armin76 Exp $

DESCRIPTION="Ruby Browser for modules/classes hierarchy and their constants and methods"
HOMEPAGE="http://ruby-gnome2.sourceforge.jp/hiki.cgi?rbbr"
SRC_URI="mirror://sourceforge/ruby-gnome2/${P}-withapi.tar.gz"

USE_RUBY="ruby18"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="Ruby"
IUSE="nls cjk"

DEPEND=">=dev-lang/ruby-1.8.0
	 >=dev-ruby/ruby-gtk2-0.9.1
	 nls? ( >=dev-ruby/ruby-gettext-0.5.5 )
	 cjk? ( >=dev-ruby/refe-0.8.0 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-withapi"

src_compile() {
	# bug #59125
	rm lib/rbbr/doc/ri2.rb || die "failed to remove ri2.rb"

	ruby install.rb config || die "install.rb config failed"
	ruby install.rb setup || die "install.rb setup failed"
}

src_install() {
	ruby install.rb install --prefix="${D}" || die "install.rb install failed"
}
