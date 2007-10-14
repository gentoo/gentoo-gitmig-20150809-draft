# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libtomoe-gtk/libtomoe-gtk-0.6.0.ebuild,v 1.4 2007/10/14 07:20:09 matsuu Exp $

MY_P="tomoe-gtk-${PV}"
DESCRIPTION="Tomoe GTK+ interface widget library"
HOMEPAGE="http://tomoe.sourceforge.jp/"
SRC_URI="mirror://sourceforge/tomoe/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc"

DEPEND=">=app-i18n/tomoe-0.6.0
	dev-python/pygtk
	dev-python/pygobject
	>=gnome-extra/gucharmap-1.4.0
	doc? ( dev-util/gtk-doc )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf $(use_enable doc gtk-doc) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README
}
