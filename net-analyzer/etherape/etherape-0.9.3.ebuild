# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/etherape/etherape-0.9.3.ebuild,v 1.1 2005/08/19 23:15:23 vanquirius Exp $

inherit eutils

DESCRIPTION="A graphical network monitor for Unix modeled after etherman"
SRC_URI="mirror://sourceforge/etherape/${P}.tar.gz"
HOMEPAGE="http://etherape.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

DEPEND=">=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	virtual/libpcap
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-res_mkquery.patch
	epatch ${FILESDIR}/${PN}-0.9.1-fix-mkinstalldirs.diff
}

src_compile() {
	aclocal || die "aclocal failed"
	autoconf || die "autoconf failed"

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	# move shortcut to gnome2 compliant location
	dodir /usr/share/applications
	mv ${D}/usr/share/gnome/apps/Applications/etherape.desktop \
		${D}/usr/share/applications
	echo "Categories=GNOME;Application;Network;" >> ${D}/usr/share/applications/etherape.desktop
	rm -rf ${D}/usr/share/gnome

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog FAQ INSTALL NEWS OVERVIEW
	dodoc README* TODO
}
