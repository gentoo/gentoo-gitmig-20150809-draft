# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libxmlpp/libxmlpp-1.0.4-r2.ebuild,v 1.2 2005/04/01 17:15:54 blubb Exp $

IUSE=""

inherit libtool eutils

MY_P=${P/pp/++}

DESCRIPTION="C++ wrapper for the libxml XML parser library"
HOMEPAGE="http://libxmlplusplus.sourceforge.net/"
SRC_URI="mirror://gnome/sources/libxml++/${PV%.*}/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

RDEPEND=">=dev-libs/libxml2-2.5.8
		>=sys-devel/automake-1.7
		>=sys-devel/autoconf-2.5"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7
	unpack "${A}"
	cd "${S}"
	epatch ${FILESDIR}/${P}-pc.patch		# closes Bug 83794
	aclocal && autoconf && automake -a && \
		libtoolize --force --copy || die
	econf || die "Configure failed."
	emake || die "Make failed."
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README*
}
