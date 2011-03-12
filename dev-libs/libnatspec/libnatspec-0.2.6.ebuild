# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnatspec/libnatspec-0.2.6.ebuild,v 1.8 2011/03/12 12:41:46 armin76 Exp $

EAPI="2"

DESCRIPTION="library to smooth charset/localization issues"
HOMEPAGE="http://natspec.sourceforge.net/"
SRC_URI="mirror://sourceforge/natspec/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="doc python"

RDEPEND="python? ( >=dev-lang/python-2.3 )
	dev-libs/popt"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	python? ( dev-lang/tcl )"

src_configure() {
	use doc || export ac_cv_prog_DOX=no
	# braindead configure script does not disable python on --without-python
	econf $(use python && use_with python)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README TODO
}
