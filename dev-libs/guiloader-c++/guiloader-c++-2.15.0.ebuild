# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/guiloader-c++/guiloader-c++-2.15.0.ebuild,v 1.1 2009/06/17 10:17:47 pva Exp $

DESCRIPTION="C++ binding to GuiLoader library"
HOMEPAGE="http://crow-designer.sourceforge.net"
SRC_URI="mirror://sourceforge/crow-designer/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls"

RDEPEND=">=dev-cpp/gtkmm-2.14.3
		>=dev-cpp/glibmm-2.18
		>=dev-libs/guiloader-2.15"
DEPEND="${RDEPEND}
		dev-libs/boost
		dev-util/pkgconfig
		nls? ( >=sys-devel/gettext-0.17 )"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc doc/{authors.txt,news.en.txt,readme.en.txt} || die
}
