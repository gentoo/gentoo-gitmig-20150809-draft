# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bins/bins-1.1.23-r1.ebuild,v 1.2 2004/04/06 04:08:53 vapier Exp $

inherit eutils

DESCRIPTION="Static HTML photo album generator"
HOMEPAGE="http://bins.sautret.org/"
SRC_URI="http://jsautret.free.fr/BINS/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~alpha ~ppc amd64"

DEPEND=">=dev-lang/perl-5.6.1-r6
	>=media-gfx/imagemagick-5.5.5.3
	>=dev-perl/perlmagick-5.5.5.3
	>=dev-perl/ImageSize-2.99
	>=dev-perl/ImageInfo-1.04-r1
	>=dev-perl/IO-String-1.01-r1
	>=dev-perl/HTML-Clean-0.8
	>=dev-perl/HTML-Parser-3.26-r1
	>=dev-perl/HTML-Template-2.6
	>=dev-perl/Locale-gettext-1.01
	>=dev-perl/Storable-2.04
	>=dev-perl/Text-Iconv-1.2
	>=dev-perl/URI-1.18
	>=dev-perl/libxml-perl-0.07-r1
	>=dev-perl/XML-DOM-1.39-r1
	>=dev-perl/XML-Grove-0.46_alpha
	>=dev-perl/XML-Handler-YAWriter-0.23
	>=dev-perl/XML-XQL-0.67"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-install.patch
}

src_install() {
	env DESTDIR=${D} PREFIX="/usr" ./install.sh || die
}
