# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/llgal/llgal-0.13.6.ebuild,v 1.1 2006/09/04 14:51:55 nattfodd Exp $

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
	epatch ${FILESDIR}/${P}-optional-po.patch
}

src_compile() {
	make PREFIX=/usr SYSCONFDIR=/etc MANDIR=/usr/share/man \
	PERL_INSTALLDIRS=vendor || die "Failed to compile"
}

src_install() {
	make DESTDIR="${D}/" PREFIX=/usr SYSCONFDIR=/etc MANDIR=/usr/share/man \
	PERL_INSTALLDIRS=vendor install || die "Failed to install"
	if use linguas_fr; then
		make DESTDIR="${D}/" PREFIX=/usr install-po \
		|| die "Failed to install po files"
	fi
	fixlocalpod
	dodoc Changes
	dohtml doc/*.html
}
