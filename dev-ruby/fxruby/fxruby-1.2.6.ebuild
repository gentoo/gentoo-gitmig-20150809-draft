# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fxruby/fxruby-1.2.6.ebuild,v 1.4 2006/04/13 12:01:44 fmccor Exp $

inherit ruby

MY_P="FXRuby-${PV}"

DESCRIPTION="Ruby language binding to the FOX GUI toolkit"
HOMEPAGE="http://www.fxruby.org/"
SRC_URI="http://rubyforge.org/frs/download.php/4003/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1.2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc x86"
IUSE="doc"

DEPEND="=x11-libs/fox-1.2*
	>=x11-libs/fxscintilla-1.62-r1"
USE_RUBY="ruby16 ruby18 ruby19"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e 's:libs, "fxscintilla":libs, "fxscintilla-1.2":g' \
		 ext/fox12/extconf.rb || die "sed error"
	einfo "Avoid -O0 builds"
	sed -i -e 's:-O0 -Iinclude:-Iinclude:g' \
		ext/fox12/extconf.rb || die "Can't fix forced -O0"
}
