# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/devilspie/devilspie-0.10.ebuild,v 1.5 2005/06/24 00:51:24 josejx Exp $

inherit eutils

DESCRIPTION="A Window Matching utility similar to Sawfish's Matched Windows feature"
HOMEPAGE="http://www.burtonini.com/blog/computers/devilspie"
SRC_URI="http://www.burtonini.com/computing/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ~sparc x86"

IUSE=""

IUSE=""
DEPEND=">=dev-util/pkgconfig-0.12.0
		>=dev-util/gob-2.0.3
		dev-libs/libxslt
		dev-lang/perl"
RDEPEND=">=x11-libs/gtk+-2.0.0
		>=x11-libs/libwnck-0.17
		>=x11-libs/startup-notification-0.5
		dev-libs/libxml2"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-make-check.patch
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"

	dodoc AUTHORS ChangeLog README NEWS TODO \
		sample-config.xml devilspie.dtd

	dohtml devilspie-reference.html
}

pkg_postinst() {
	einfo
	einfo "A sample config file has been installed in /usr/share/doc/${P}"
	einfo "as sample-config.xml.gz.  Also installed there is the DTD for"
	einfo "the config file.  It is called devilspie.dtd.gz"
	ewarn
	ewarn "BEFORE starting devilspie, you MUST create a .devilspie.xml file"
	ewarn "in your home directory so that it knows what to do.  Please use"
	ewarn "the sample config file as a starting point."
	ewarn
}
