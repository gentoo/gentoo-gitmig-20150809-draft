# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camomile/camomile-0.5.3.ebuild,v 1.3 2004/08/09 18:48:39 mr_bones_ Exp $

DESCRIPTION="Camomile is a comprehensive Unicode library for ocaml."
HOMEPAGE="http://camomile.sourceforge.net/"
SRC_URI="http://heanet.dl.sourceforge.net/sourceforge/camomile/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.07"

src_compile() {
	econf || die
	# Does not support parallel builds.
	emake -j1
}

src_install() {
	local destdir="$(ocamlfind printconf destdir)"

	export OCAMLFIND_DESTDIR="${D}${destdir}"

	# stublibs style
	dodir "${destdir}/stublibs"

	make DESTDIR="${D}" DATADIR="${D}/usr/share" install \
		|| die "make install failed"
}
