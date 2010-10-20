# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rcairo/rcairo-1.8.1.ebuild,v 1.6 2010/10/20 21:45:30 ranger Exp $

EAPI=2
USE_RUBY="ruby18"

# Documentation depends on files that are not distributed.
RUBY_FAKEGEM_TASK_DOC=""

# Depends on test-unit-2 which is currently masked.
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="AUTHORS ChangeLog NEWS README"

inherit ruby-fakegem

IUSE="svg"

DESCRIPTION="Ruby bindings for cairo"
HOMEPAGE="http://cairographics.org/rcairo/"
SRC_URI="mirror://rubygems/cairo-${PV}.gem"

SLOT="0"
LICENSE="|| ( Ruby GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"

RDEPEND="${RDEPEND}
	>=x11-libs/cairo-1.2.0[svg?]"
DEPEND="${DEPEND}
	>=x11-libs/cairo-1.2.0[svg?]
	dev-util/pkgconfig"

each_ruby_configure() {
	${RUBY} extconf.rb
}

each_ruby_compile() {
	emake
}

each_ruby_install() {
	ruby_fakegem_genspec

	emake install DESTDIR="${D}"
}

all_ruby_install() {
	dohtml -r doc/* || die "Cannot install documentation."

	insinto /usr/share/doc/${PF}/samples
	doins -r samples/* || die "Cannot install sample files."
}
