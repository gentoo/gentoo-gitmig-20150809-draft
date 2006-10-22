# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/llgal/llgal-0.13.7.ebuild,v 1.1 2006/10/22 20:36:11 nattfodd Exp $

inherit perl-module

DESCRIPTION="Command-line static web gallery generator"
HOMEPAGE="http://home.gna.org/llgal"
SRC_URI="http://download.gna.org/llgal/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE="exif"
LINS="fr"

for ((i=0; i<${#LINS[@]}; i++)) do
	IUSE="${IUSE} linguas_${LINS[$i]}"
done

RDEPEND="media-gfx/imagemagick
	 dev-lang/perl
	 dev-perl/ImageSize
	 dev-perl/URI
	 dev-perl/Locale-gettext
	 exif? ( media-libs/exiftool )"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch ${FILESDIR}/${P}-install-doc.patch
}

src_compile() {
	make PREFIX=/usr SYSCONFDIR=/etc MANDIR=/usr/share/man \
	PERL_INSTALLDIRS=vendor || die "Failed to compile"
}

src_install() {
	make DESTDIR="${D}/" LOCALES="${LINGUAS}" PREFIX=/usr SYSCONFDIR=/etc \
	MANDIR=/usr/share/man PERL_INSTALLDIRS=vendor \
	install install-doc DOCDIR=/usr/share/doc/${P}/ \
	|| die "Failed to install"
	fixlocalpod
	dodoc Changes
}
