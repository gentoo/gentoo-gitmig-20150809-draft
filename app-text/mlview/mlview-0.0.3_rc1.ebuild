# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mlview/mlview-0.0.3_rc1.ebuild,v 1.1 2002/11/05 12:21:45 leonardop Exp $

DESCRIPTION="XML Editor for Gnome"
HOMEPAGE="http://www.nongnu.org/mlview/"
MY_P=${P/_/}
SRC_URI="http://savannah.gnu.org/download/${PN}/tarballs/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

DEPEND="gnome-base/gnome-libs
	>=dev-libs/libxml2-2.4.22
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	local myconf=""

	use nls || myconf="--disable-nls"
	
	econf $myconf || die "./configure failed"
		
	# The presence of this file breaks the compilation without nls
	[ -f ${S}/intl/libintl.h ] && rm ${S}/intl/libintl.h
	
	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"

	dodoc ABOUT-NLS AUTHORS BRANCHES COPYING ChangeLog NEWS README TODO
}
