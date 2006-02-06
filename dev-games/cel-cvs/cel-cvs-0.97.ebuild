# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cel-cvs/cel-cvs-0.97.ebuild,v 1.12 2006/02/06 01:21:59 vapier Exp $

ECVS_SERVER="cvs.cel.sourceforge.net:/cvsroot/cel"
ECVS_MODULE="cel"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
inherit cvs

DESCRIPTION="A game entity layer based on Crystal Space"
HOMEPAGE="http://cel.sourceforge.net/"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="python"

RDEPEND="dev-games/crystalspace
	dev-util/jam
	!dev-games/cel
	python? ( virtual/python )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
	local prefix=$(cs-config --prefix)
	./autogen.sh || die "autogen failed"
	PATH="${prefix}/bin:${PATH}" \
	./configure \
		--prefix="${prefix}" \
		--with-cs-prefix="${prefix}" \
		$(use_with python) \
		|| die "configure failed"
	jam || die
}

src_install() {
	local prefix=$(cs-config --prefix)
	jam -sprefix="${D}"${prefix} install || die
}
