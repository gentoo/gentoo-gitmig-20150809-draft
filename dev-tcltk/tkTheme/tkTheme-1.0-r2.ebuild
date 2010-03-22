# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkTheme/tkTheme-1.0-r2.ebuild,v 1.2 2010/03/22 20:43:40 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Tcl/Tk Theming library."
HOMEPAGE="http://www.xmission.com/~georgeps/Tk_Theme/other/"
SRC_URI="http://www.xmission.com/~georgeps/Tk_Theme/other/${PN}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="
	>=dev-lang/tk-8.3.3
	x11-libs/libXpm"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch ${FILESDIR}/${PV}-Makefile.in.diff
	epatch ${FILESDIR}/${PV}-configure.diff
	tc-export CC
}

src_configure() {
	econf --with-tcl="${EPREFIX}"/usr/$(get_libdir) --with-tk="${EPREFIX}"/usr/$(get_libdir)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO || die
}
