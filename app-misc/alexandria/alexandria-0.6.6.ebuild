# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/alexandria/alexandria-0.6.6.ebuild,v 1.3 2010/06/28 11:40:00 fauli Exp $

inherit gnome2 ruby

DESCRIPTION="A GNOME application to help you manage your book collection"
HOMEPAGE="http://alexandria.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="evo"

DOCS="ChangeLog README TODO"

RDEPEND=">=dev-lang/ruby-1.8.0
	>=dev-ruby/ruby-gettext-0.6.1
	>=dev-ruby/ruby-gnome2-0.16.0
	>=dev-ruby/ruby-libglade2-0.12.0
	>=dev-ruby/ruby-gconf2-0.12.0
	>=dev-ruby/imagesize-0.1.1
	dev-ruby/hpricot
	evo? ( >=dev-ruby/revolution-0.5 )"

DEPEND=">=dev-lang/ruby-1.8.0
	app-text/scrollkeeper
	dev-ruby/rake"

PATCHES=(
	"${FILESDIR}/${P}-Rakefile.patch"
)

src_compile() {
	rake || die
}

src_install() {
	export DESTDIR="${D}" PREFIX=/usr
	rake install_package_staging || die

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
	elog "    dev-ruby/htmlentities"
	echo
	elog "  For Z39.50 support and the Library of Congress and"
	elog "  British Library book proviers:"
	elog "    dev-ruby/ruby-zoom"
}
