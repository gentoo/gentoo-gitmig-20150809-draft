# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/ci/ci-1.1.3.ebuild,v 1.1 2004/01/11 17:36:45 usata Exp $

IUSE=""

DESCRIPTION="C.i. - Compact Interface for 2ch"
HOMEPAGE="http://wids.net/lab/Ci.html"
if [ "${P/_/}" = "${P}" ] ; then
	# normal release
	#MY_P=${PN}.nr${PV%%.*}
	MY_PV=delta${PV##*.}
	MY_P=${PN}.${MY_PV}
	SRC_URI="http://wids.net/archive/Ci/${MY_P}.tar.gz"
else
	# snapshot
	MY_PV=${PV#*_p}
	MY_P=${PN}.snapshot-${MY_PV}
	SRC_URI="http://wids.net/archive/Ci/snapshot/${MY_P}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=sys-apps/sed-4"
RDEPEND="dev-lang/ruby
	=x11-libs/gtk+-1.2*
	>=dev-ruby/ruby-gtk-0.28
	media-fonts/monafont"

S=${WORKDIR}/Ci-${MY_PV}

src_compile() {

	local rubycmd bindir libdir datadir

	if [ -d /usr/share/migemo ] ; then
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
	#dosed /usr/lib/ruby/site_ruby/ci/gtkext.rb || die
	dosed /usr/lib/ruby/site_ruby/ci/sitecfg.rb || die

	dodoc Changelog README *.sample doc/*.rd
	cd doc
	dohtml -r .
}
