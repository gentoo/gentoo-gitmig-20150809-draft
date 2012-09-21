# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/liblangtag/liblangtag-0.3-r1.ebuild,v 1.2 2012/09/21 07:22:09 scarabeus Exp $

EAPI=4

inherit base autotools

DESCRIPTION="An interface library to access tags for identifying languages"
HOMEPAGE="https://github.com/tagoh/liblangtag/"
SRC_URI="https://github.com/downloads/tagoh/${PN}/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="introspection static-libs test"

RDEPEND="
	dev-libs/glib
	dev-libs/libxml2
	introspection? ( >=dev-libs/gobject-introspection-0.10.8 )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	test? ( dev-libs/check )
	>=dev-util/gtk-doc-am-1.13
	dev-libs/gobject-introspection-common
"
# gtk-doc-am and gobject-introspection-common required by autoreconf

PATCHES=(
	"${FILESDIR}/${P}-automagic-tests.patch"
)

# Upstream expect liblangtag to be installed when one runs tests...
RESTRICT="test"

src_prepare() {
	base_src_prepare

	# fixed in git
	sed -i \
		-e 's:$(libdir):${libdir}:g' \
		*.pc.in || die

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable introspection) \
		$(use_enable static-libs static) \
		$(use_enable test)
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +
}
