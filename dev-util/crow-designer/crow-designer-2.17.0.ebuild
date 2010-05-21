# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/crow-designer/crow-designer-2.17.0.ebuild,v 1.3 2010/05/21 08:58:14 pva Exp $

EAPI="2"

DESCRIPTION="GTK+ GUI building tool"
HOMEPAGE="http://www.crowdesigner.org"
SRC_URI="http://nothing-personal.googlecode.com/files/crow-${PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

LANGS="ru"

RDEPEND=">=dev-libs/guiloader-2.17
	>=dev-libs/guiloader-c++-2.17
	dev-cpp/gtkmm
	>=dev-libs/dbus-glib-0.82"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-util/pkgconfig
	nls? ( >=sys-devel/gettext-0.17 )"

S=${WORKDIR}/crow-${PV}

for x in ${LANGS}; do
	IUSE="${IUSE} linguas_${x}"
done

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc doc/{authors.txt,news.{en,ru}.txt,readme.{en,ru}.txt,readme.ru.txt} || die
}
