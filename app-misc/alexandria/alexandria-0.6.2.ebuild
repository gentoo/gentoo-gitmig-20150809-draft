# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/alexandria/alexandria-0.6.2.ebuild,v 1.1 2008/03/09 10:23:12 graaff Exp $

inherit ruby gnome2 eutils

IUSE=""

DESCRIPTION="A GNOME application to help you manage your book collection"
HOMEPAGE="http://alexandria.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/29501/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

USE_RUBY="ruby18"

DOCS="COPYING ChangeLog README TODO"

RDEPEND=">=dev-lang/ruby-1.8.0
	>=dev-ruby/ruby-gettext-0.6.1
	>=dev-ruby/ruby-gnome2-0.14.0
	>=dev-ruby/ruby-libglade2-0.12.0
	>=dev-ruby/ruby-gconf2-0.12.0
	>=dev-ruby/ruby-gdkpixbuf2-0.12.0
	>=dev-ruby/ruby-amazon-0.8.3
	>=dev-ruby/ruby-zoom-0.2.0"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-ruby/rake"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	epatch "${FILESDIR}/${PN}-rakefile.patch"
	epatch "${FILESDIR}/${P}-rake-0.8.1.patch"
}

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
}
