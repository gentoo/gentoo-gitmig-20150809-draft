# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/etherape/etherape-0.9.1.ebuild,v 1.2 2005/01/29 05:12:51 dragonheart Exp $

inherit eutils

IUSE=""
DESCRIPTION="A graphical network monitor for Unix modeled after etherman"
SRC_URI="mirror://sourceforge/etherape/${P}.tar.gz"
HOMEPAGE="http://etherape.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

DEPEND=">=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	virtual/libpcap
	sys-devel/gettext
	sys-devel/autoconf"

src_install() {
	emake DESTDIR=${D} install || die "failed to install"

	# move shortcut to gnome2 compliant location
	dodir /usr/share/applications
	mv ${D}/usr/share/gnome/apps/Applications/etherape.desktop \
		${D}/usr/share/applications
	echo "Categories=GNOME;Application;Network;" >> ${D}/usr/share/applications/etherape.desktop
	rm -rf ${D}/usr/share/gnome

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog FAQ INSTALL NEWS OVERVIEW
	dodoc README* TODO
}

