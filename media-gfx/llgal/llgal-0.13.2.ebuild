# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/llgal/llgal-0.13.2.ebuild,v 1.1 2006/04/27 07:49:20 nattfodd Exp $

inherit perl-module

DESCRIPTION="Command-line online gallery generator"
HOMEPAGE="http://home.gna.org/llgal"
SRC_URI="http://download.gna.org/llgal/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""

RDEPEND="media-gfx/imagemagick
	 dev-lang/perl
	 dev-perl/ImageSize
	 dev-perl/URI
	 dev-perl/Locale-gettext
	 media-libs/exiftool"

src_compile() {
	make PREFIX=/usr SYSCONFDIR=/etc MANDIR=/usr/share/man \
	PERL_INSTALLDIRS=vendor || die "Failed to compile"
}

src_install() {
	make DESTDIR="${D}/" PREFIX=/usr SYSCONFDIR=/etc MANDIR=/usr/share/man \
	PERL_INSTALLDIRS=vendor install || die "Failed to install"
	fixlocalpod
	dodoc Changes UPGRADE
}
