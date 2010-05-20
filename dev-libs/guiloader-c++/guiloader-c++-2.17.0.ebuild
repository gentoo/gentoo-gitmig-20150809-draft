# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/guiloader-c++/guiloader-c++-2.17.0.ebuild,v 1.2 2010/05/20 03:19:13 pva Exp $

EAPI="2"

DESCRIPTION="C++ binding to GuiLoader library"
HOMEPAGE="http://www.crowdesigner.org"
SRC_URI="http://nothing-personal.googlecode.com/files/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND=">=dev-libs/guiloader-2.17
	>=dev-cpp/gtkmm-2.18
	>=dev-cpp/glibmm-2.22"
DEPEND="${RDEPEND}
		dev-libs/boost
		dev-util/pkgconfig
		nls? ( >=sys-devel/gettext-0.17 )"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc doc/{authors.txt,news.en.txt,readme.en.txt} || die
}
