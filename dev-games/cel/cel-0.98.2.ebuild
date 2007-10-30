# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cel/cel-0.98.2.ebuild,v 1.3 2007/10/30 17:10:39 nixnut Exp $

inherit eutils

MY_P="cel${PV:2:2}_00${PV:5:1}"
DESCRIPTION="A game entity layer based on Crystal Space"
HOMEPAGE="http://cel.sourceforge.net/"
SRC_URI="mirror://sourceforge/cel/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="python"

RDEPEND="dev-games/crystalspace
	dev-util/jam
	!dev-games/cel-cvs
	python? ( virtual/python )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}

src_compile() {
	local prefix=$(cs-config --prefix)

	PATH="${prefix}/bin:${PATH}" \
	./configure \
		--prefix="${prefix}" \
		--with-cs-prefix="${prefix}" \
		$(use_with python) \
		|| die "configure failed"
	jam || die "jam failed"
}

src_install() {
	local prefix=$(cs-config --prefix)
	jam -sprefix="${D}"${prefix} install || die
}
