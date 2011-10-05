# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxshortcut/lxshortcut-0.1.2.ebuild,v 1.2 2011/10/05 07:26:08 nativemad Exp $

EAPI="4"

inherit autotools eutils

DESCRIPTION="LXDE tool to edit desktop entry files"
HOMEPAGE="http://lxde.sourceforge.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	 dev-libs/glib:2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog README
}
