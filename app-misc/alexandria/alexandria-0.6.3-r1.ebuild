# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/alexandria/alexandria-0.6.3-r1.ebuild,v 1.1 2009/01/18 10:51:02 a3li Exp $

inherit gnome2 ruby

IUSE="evo"

DESCRIPTION="A GNOME application to help you manage your book collection"
HOMEPAGE="http://alexandria.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS="COPYING ChangeLog README TODO"

RDEPEND=">=dev-lang/ruby-1.8.0
	>=dev-ruby/ruby-gettext-0.6.1
	>=dev-ruby/ruby-gnome2-0.16.0
	>=dev-ruby/ruby-libglade2-0.12.0
	>=dev-ruby/ruby-gconf2-0.12.0
	>=dev-ruby/imagesize-0.1.1
	evo? ( >=dev-ruby/revolution-0.5 )"

DEPEND=">=dev-lang/ruby-1.8.0
	app-text/scrollkeeper
	dev-ruby/rake"

PATCHES=(
	"${FILESDIR}/${PN}-rakefile.patch"
	"${FILESDIR}/${P}-no_amazon_3.0.diff"
	"${FILESDIR}/${P}-tooltips.patch"
)

src_compile() {
	rake || die
}

src_install() {
	export PREFIX="${D}/usr"
	rake install || die

	[ -n "${DOCS}" ] && dodoc ${DOCS}

	# Move the installed docs to the gentoo standard directory
	for doc in "${D}/usr/share/doc/alexandria/*"
	do
		dodoc $doc
	done
	rm -rf "${D}/usr/share/doc/alexandria"
}

pkg_postinst() {
	unset PREFIX

	gnome2_gconf_install

	# For the next line see bug #76726
	"${ROOT}/usr/bin/gconftool-2" --shutdown

	echo
	elog "To enable some book providers you will need to emerge"
	elog "additional packages:"
	echo
	elog "  For the Deastore book provider:"
	elog "    dev-ruby/mechanize"
	echo
	elog "  For Z39.50 support and the Library of Congress and"
	elog "  British Library book proviers:"
	elog "    dev-ruby/ruby-zoom"
	echo
	elog "  For the Amazon book provider:"
	elog "    dev-ruby/hpricot"
	echo
}
