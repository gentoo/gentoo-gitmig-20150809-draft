# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gettext/ruby-gettext-0.5.5.ebuild,v 1.7 2005/03/25 23:34:50 blubb Exp $

inherit ruby

DESCRIPTION="Ruby GetText Package is Native Language Support Library and Tools which modeled after GNU gettext package"
HOMEPAGE="http://ponx.s5.xrea.com/hiki/ruby-gettext.html"
# The source tarball was downloaded from the site above
SRC_URI="mirror://gentoo/${PN}-package-${PV}.tar.gz"

KEYWORDS="x86 ppc"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
SLOT="0"
LICENSE="Ruby"

DEPEND="virtual/ruby
	sys-devel/gettext
	dev-ruby/rdtool
	>=dev-ruby/racc-1.4.4"

S="${WORKDIR}/${PN}-package-${PV}"

src_compile() {
	ruby install.rb config --prefix="${D}/usr" || die "install.rb config failed"
	ruby install.rb setup || die "install.rb setup failed"
}

src_install() {
	export LC_ALL=C
	ruby install.rb install || die "install.rb install failed"
	cd docs
	ruby makehtml.rb
	cd -
	erubydoc
}
