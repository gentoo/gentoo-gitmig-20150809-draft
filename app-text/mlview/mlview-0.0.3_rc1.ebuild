# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mlview/mlview-0.0.3_rc1.ebuild,v 1.5 2004/01/25 12:13:46 obz Exp $

MY_P=${P/_/}
DESCRIPTION="XML Editor for Gnome"
HOMEPAGE="http://www.nongnu.org/mlview/"
SRC_URI="http://savannah.gnu.org/download/${PN}/tarballs/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

DEPEND="gnome-base/gnome-libs
	>=dev-libs/libxml2-2.4.22
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf `use_enable nls`

	# The presence of this file breaks the compilation without nls
	[ -f ${S}/intl/libintl.h ] && rm ${S}/intl/libintl.h

	emake || die "Compilation failed"
}

src_install() {
	einstall
	dodoc ABOUT-NLS AUTHORS BRANCHES COPYING ChangeLog NEWS README TODO
}
