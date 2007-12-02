# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/verbiste/verbiste-0.1.21.ebuild,v 1.1 2007/12/02 18:12:48 tester Exp $

inherit autotools eutils

DESCRIPTION="French conjugation system"
HOMEPAGE="http://sarrazip.com/dev/verbiste.html"
SRC_URI="http://sarrazip.com/dev/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="gnome gtk"

RDEPEND=">=dev-libs/libxml2-2.4.0
	gtk? ( >=x11-libs/gtk+-2.6 )
	gnome? ( >=gnome-base/gnome-panel-2.0
		>=gnome-base/libgnomeui-2.0 )"

DEPEND="${RDEPEND}"

#tests fails
RESTRICT=test

src_compile() {
	econf \
		$(use_with gtk gtk-app) \
		$(use_with gnome gnome-app) \
		$(use_with gnome gnome-applet) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "can't install"
	dodoc AUTHORS ChangeLog HACKING LISEZMOI NEWS README THANKS TODO
}
