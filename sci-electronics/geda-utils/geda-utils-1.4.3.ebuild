# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/geda-utils/geda-utils-1.4.3.ebuild,v 1.2 2009/05/22 08:13:47 mr_bones_ Exp $

EAPI="2"

inherit versionator

DESCRIPTION="GPL Electronic Design Automation: utilities"
HOMEPAGE="http://www.gpleda.org/"
URI_BASE="http://geda.seul.org/release/v$(get_version_component_range 1-2)"
SRC_URI="${URI_BASE}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="=sci-libs/libgeda-${PV}*
	=sci-electronics/geda-symbols-${PV}*
	>=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.4
	|| ( =dev-scheme/guile-1.6* =dev-scheme/guile-1.8*[deprecated] )"

DEPEND="${RDEPEND}
	!<sci-electronics/geda-1.4.3-r1
	>=dev-util/pkgconfig-0.9"

src_prepare() {
	sed -i -e 's/ docs / /' Makefile.in || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS NEWS README docs/README.*
}
