# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/crow-designer/crow-designer-2.17.0.ebuild,v 1.1 2010/05/08 06:46:17 pva Exp $

EAPI="2"

DESCRIPTION="GTK+ GUI building tool"
HOMEPAGE="http://crow-designer.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/crow-${PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/guiloader-2.17
	>=dev-libs/guiloader-c++-2.17
	dev-cpp/gtkmm
	>=dev-libs/dbus-glib-0.82"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-util/pkgconfig"

S=${WORKDIR}/crow-${PV}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc doc/{authors.txt,news.{en,ru}.txt,readme.{en,ru}.txt,readme.ru.txt} || die
}
