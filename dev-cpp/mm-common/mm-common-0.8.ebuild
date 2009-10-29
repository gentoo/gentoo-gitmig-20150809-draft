# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/mm-common/mm-common-0.8.ebuild,v 1.1 2009/10/29 22:57:21 eva Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Build infrastructure and utilities for GNOME C++ bindings"
HOMEPAGE="http://www.gtkmm.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	|| (
		net-misc/wget
		net-misc/curl )"

src_install() {
	gnome2_src_install

	find "${D}" -name ".gitignore" -delete || die "could not delete .gitignore"
}
