# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/guiloader/guiloader-2.17.0.ebuild,v 1.2 2010/05/20 03:17:26 pva Exp $

EAPI="2"

DESCRIPTION="library to create GTK+ interfaces from GuiXml at runtime"
HOMEPAGE="http://www.crowdesigner.org"
SRC_URI="http://nothing-personal.googlecode.com/files/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.18:2
	>=dev-libs/glib-2.22:2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( >=sys-devel/gettext-0.17 )"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc doc/{authors.txt,news.{ru,en}.txt,readme.{ru,en}.txt} || die
}
