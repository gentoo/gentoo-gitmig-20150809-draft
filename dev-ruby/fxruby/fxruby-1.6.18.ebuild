# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fxruby/fxruby-1.6.18.ebuild,v 1.3 2009/01/02 04:41:08 mr_bones_ Exp $

RUBY_BUG_145222=yes
inherit ruby

MY_P="FXRuby-${PV}"

DESCRIPTION="Ruby language binding to the FOX GUI toolkit"
HOMEPAGE="http://www.fxruby.org/"
SRC_URI="mirror://rubyforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1.6"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE="examples doc"

DEPEND="=x11-libs/fox-1.6*
	>=x11-libs/fxscintilla-1.62-r1"
USE_RUBY="ruby18 ruby19"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e 's:libs, "fxscintilla":libs, "fxscintilla-1.6":g' \
		 ext/fox16/extconf.rb || die "sed error"
	einfo "Avoid -O0 builds"
	sed -i -e 's:-O0 -Iinclude:-Iinclude:g' \
		ext/fox16/extconf.rb || die "Can't fix forced -O0"
}

src_install() {
	${RUBY} install.rb config --prefix="${D}/usr" "$@" \
		${RUBY_ECONF} || die "install.rb config failed"

	${RUBY} install.rb install "$@" --prefix="${D}" \
		${RUBY_ECONF} || die "install.rb install failed"
}
