# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/devilspie/devilspie-0.3.1.ebuild,v 1.2 2004/03/31 07:59:57 mr_bones_ Exp $

DESCRIPTION="A Window Matching utility similar to Sawfish's Matched Windows feature"
HOMEPAGE="http://www.burtonini.com/blog/computers/devilspie"
SRC_URI="http://www.burtonini.com/computing/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~sparc"
IUSE=""

RDEPEND="dev-lang/perl
	sys-libs/zlib
	x11-libs/pango
	dev-libs/libxml2
	>=dev-util/gob-2.0.3
	>=x11-libs/gtk+-2.0.0
	>=x11-libs/libwnck-0.17
	>=gnome-base/libglade-2.0.1
	>=x11-libs/startup-notification-0.5"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

IUSE=""

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README NEWS TODO \
		sample-config.xml devilspie.dtd || \
			die "dodoc failed"
}

pkg_postinst() {
	echo
	einfo "A sample config file has been installed in /usr/share/doc/${P}"
	einfo "as sample-config.xml.gz.  Also installed there is the DTD for"
	einfo "the config file.  It is called devilspie.dtd.gz"
	echo
	ewarn "BEFORE starting devilspie, you MUST create a .devilspie.xml file"
	ewarn "in your home directory so that it knows what to do.  Please use"
	ewarn "the sample config file as a starting point."
	echo
}
