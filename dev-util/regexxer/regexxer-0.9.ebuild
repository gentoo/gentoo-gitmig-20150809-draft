# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/regexxer/regexxer-0.9.ebuild,v 1.2 2007/05/02 15:43:22 armin76 Exp $

GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="An interactive tool for performing search and replace operations"
HOMEPAGE="http://regexxer.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

RDEPEND=">=dev-cpp/libglademm-2.4.0
	>=dev-libs/libsigc++-2.0
	>=dev-cpp/gtkmm-2.6.0
	>=dev-libs/libpcre-4.0
	>=dev-cpp/gconfmm-2.6.1"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

pkg_setup() {
	if has_version ">=dev-cpp/gtkmm-2.10.2" && ! built_with_use dev-cpp/gtkmm accessibility; then
		eerror "In order to compile regexxer you need to recompile gtkmm with"
		eerror "accessibility USE flag enabled."
		die "Recompile gtkmm with accessibility USE flag enabled."
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
