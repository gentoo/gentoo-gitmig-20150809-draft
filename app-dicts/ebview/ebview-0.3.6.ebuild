# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ebview/ebview-0.3.6.ebuild,v 1.6 2006/11/04 17:24:56 usata Exp $

inherit eutils

IUSE=""

DESCRIPTION="EBView -- Electronic Book Viewer based on GTK+"
HOMEPAGE="http://ebview.sourceforge.net/"
SRC_URI="mirror://sourceforge/ebview/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc"

RDEPEND=">=dev-libs/eb-3.3.4
	>=x11-libs/gtk+-2.2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig"

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-destdir.diff
	epatch ${FILESDIR}/${P}-gtk28.diff
	if has_version '>=sys-devel/gettext-0.12' ; then
		cd ${S}/po
		epatch ${FILESDIR}/${PN}-gettext-0.12-gentoo.diff
	fi
}

src_compile() {

	econf --with-eb-conf=/etc/eb.conf || die
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die

	dodoc ABOUT-NLS AUTHORS ChangeLog INSTALL* NEWS README TODO
}
