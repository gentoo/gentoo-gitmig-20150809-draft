# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/etherape/etherape-0.9.0.ebuild,v 1.4 2004/02/06 12:55:56 aliz Exp $

IUSE=""
DESCRIPTION="A graphical network monitor for Unix modeled after etherman"
SRC_URI="mirror://sourceforge/etherape/${P}.tar.gz"
HOMEPAGE="http://etherape.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~amd64"

DEPEND=">=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	>=net-libs/libpcap-0.6.1
	sys-devel/gettext
	sys-devel/autoconf"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-libpcap-include.patch
	epatch ${FILESDIR}/${P}-res_mkquery.patch
}

src_compile() {
	aclocal
	autoconf

	econf || die
	emake || die
}

src_install() {
	einstall

	# move shortcut to gnome2 compliant location
	dodir /usr/share/applications
	mv ${D}/usr/share/gnome/apps/Applications/etherape.desktop \
		${D}/usr/share/applications
	echo "Categories=GNOME;Application;Network;" >> ${D}/usr/share/applications/etherape.desktop
	rm -rf ${D}/usr/share/gnome

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog FAQ INSTALL NEWS OVERVIEW
	dodoc README* TODO
}

