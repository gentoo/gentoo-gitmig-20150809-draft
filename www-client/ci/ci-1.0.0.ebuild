# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/ci/ci-1.0.0.ebuild,v 1.1 2004/09/08 13:31:55 usata Exp $

IUSE=""

MY_P=${PN}.nr${PV%%.*}

DESCRIPTION="C.i. - Compact Interface for 2ch"
HOMEPAGE="http://wids.net/lab/Ci.html"
SRC_URI="http://wids.net/archive/Ci/${MY_P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=sys-apps/sed-4"
RDEPEND="virtual/ruby
	=x11-libs/gtk+-1.2*
	>=dev-ruby/ruby-gtk-0.28
	media-fonts/monafont"

S=${WORKDIR}/Ci

src_compile() {

	local rubycmd bindir libdir datadir

	if has_version 'app-text/migemo' ; then
		local migemoDict=/usr/share/migemo/migemo-dict
		local migemoDictCache=/usr/share/migemo/migemo-dict.cache
		sed -i -e "/^migemoDict /s|''|'${migemoDict}'|" \
			-e "/^migemoDictCache /s|''|'${migemoDictCache}'|" \
			Ci.rb
	fi
	sed -i -e "/^scriptRoot = ''/s:'':'/usr/share/ci/':" Ci.rb

	sed -i -e "/^rubycmd = ''/s:'':'/usr/bin/ruby':" \
		-e "/^bindir  = ''/s:'':'/usr/bin':" \
		-e "/^libdir  = ''/s:'':'/usr/lib/ruby/site_ruby':" \
		-e "/^datadir = ''/s:'':'/usr/share':" \
		install.rb || die

	ruby install.rb config || die
}

src_install() {

	sed -i -e "/^bindir/s:/usr:${D}/usr:" \
		-e "/^libdir/s:/usr:${D}/usr:" \
		-e "/^datadir/s:/usr:${D}/usr:" \
		install.rb || die
	ruby install.rb install || die

	dosed /usr/lib/ruby/site_ruby/ci/siteconfig.rb || die

	dodoc Changelog README *.sample keybinds
}
