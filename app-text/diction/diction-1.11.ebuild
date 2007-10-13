# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/diction/diction-1.11.ebuild,v 1.2 2007/10/13 22:46:50 mr_bones_ Exp $

inherit eutils versionator

MY_PV=$(replace_version_separator 2 -)

DESCRIPTION="Diction and style checkers for english and german texts"
HOMEPAGE="http://www.gnu.org/software/diction/diction.html"
SRC_URI="http://www.moria.de/~michael/diction/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~ppc-macos ~sparc ~x86"
IUSE="unicode"

DEPEND="sys-devel/gettext"
RDEPEND="virtual/libintl"

S="${WORKDIR}"/${PN}-$(get_version_component_range 1-2)

src_unpack() {
	unpack "${A}"; cd "${S}"
	if use unicode; then
		iconv -f ISO-8859-1 -t UTF-8 de > de.new || die "charset conversion failed."
		mv de.new de
	fi
}

src_install() {
	make DESTDIR="${D}" install
	dodoc NEWS README
}
