# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/iwidgets/iwidgets-4.0.1-r1.ebuild,v 1.2 2007/06/26 23:57:35 matsuu Exp $

inherit multilib

MY_P="${PN}${PV}"
S="${WORKDIR}/${MY_P}"
ITCL_MY_P="itcl3.2.1"

DESCRIPTION="Widget collection for incrTcl/incrTk"
HOMEPAGE="http://incrtcl.sourceforge.net/itcl/"
SRC_URI="mirror://sourceforge/incrtcl/${MY_P}.tar.gz
	mirror://sourceforge/incrtcl/${ITCL_MY_P}_src.tgz"

LICENSE="as-is BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-tcltk/itcl-3.2.1
	>=dev-tcltk/itk-3.2.1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "/^\(LIB\|SCRIPT\)_INSTALL_DIR =/s|lib|$(get_libdir)|" \
		Makefile.in || die

	# Bug 115470
	rm doc/panedwindow.n
}

src_compile() {
	econf --with-itcl="${WORKDIR}/${ITCL_MY_P}" || die "configure failed"
	# we don't need to compile anything
}

src_install() {
	# parallel borks #177088
	emake -j1 INSTALL_ROOT="${D}" install || die "emake install failed"

	dodoc CHANGES ChangeLog README license.terms
	doman doc/*.n
}
