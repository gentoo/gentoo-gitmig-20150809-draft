# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gorua/gorua-0.16-r2.ebuild,v 1.1 2003/12/26 17:55:16 usata Exp $

IUSE=""

MY_P=${P/gorua/goRua}

DESCRIPTION="goRua -- Gtk+ on Ruby User Agent for 2ch"
HOMEPAGE="http://www.unixuser.org/~haruyama/software/goRua/"
SRC_URI="http://www.unixuser.org/~haruyama/software/goRua/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~sparc"

DEPEND=">=dev-lang/ruby-1.6.8
	=x11-libs/gtk+-1.2*
	>=dev-ruby/ruby-gtk-0.28
	>=media-fonts/monafont-2.22
	>=dev-ruby/ruby-zlib-0.5.1"

S=${WORKDIR}/${MY_P}

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gorua-bbsmenu-update-gentoo.diff
	epatch ${FILESDIR}/${P}-ruby18-gentoo.diff
}

src_compile() {

	sed -e "s|%%GORUA_DATADIR%%|\"/usr/share/${PF}\"|" \
		${FILESDIR}/goRua.sh > ${T}/goRua
	sed -e "s|%%GORUA_DATADIR%%|\"/usr/share/${PF}\"|" \
		new_2ch_bbsmenu.rb > ${T}/new_2ch_bbsmenu.rb
	sed -e "s|/usr/share/goRua|\"/usr/share/${PF}/dot.goRua_2ch\"|" \
		goRua.rb > ${T}/goRua.rb
}

src_install() {

	local sitedir=`ruby -r rbconfig -e 'print Config::CONFIG["sitedir"]'`
	dobin ${T}/goRua.rb ${T}/goRua

	insinto ${sitedir}
	doins connect2ch.rb goRua_color_table.rb

	exeinto /usr/share/${PF}
	doexe goRua_url_updator.rb goRua_bookmarks_translator.rb \
		goRua_cache_clean.rb ${T}/new_2ch_bbsmenu.rb
	insinto /usr/share/${PF}
	doins Makefile
	cp ${FILESDIR}/bookmarks_sample .goRua_2ch/bookmarks
	cp -r .goRua_2ch ${D}/usr/share/${PF}/dot.goRua_2ch

	dodoc ChangeLog README
}
