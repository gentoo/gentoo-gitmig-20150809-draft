# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perlmagick/perlmagick-5.5.7.15.ebuild,v 1.6 2004/07/14 20:07:45 agriffis Exp $

inherit perl-module eutils

# Left this the same as ImageMagick for the sake of simplicity
MY_PN=ImageMagick

MY_P=${MY_PN}-${PV%.*}-${PV#*.*.*.}
MY_P2=${MY_PN}-${PV%.*}

S=${WORKDIR}/${MY_P2}
DESCRIPTION="A Perl module to harness the powers of ImageMagick"
HOMEPAGE="http://www.imagemagick.org/"
SRC_URI="mirror://sourceforge/imagemagick/${MY_P}.tar.bz2"
RESTRICT="nomirror"

KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE=""
SLOT="0"
LICENSE="as-is"

DEPEND="=media-gfx/imagemagick-${PV}*
	>=dev-lang/perl-5"

src_compile() {
	#patch to allow building by perl
	epatch ${FILESDIR}/perlpatch.diff

	cd PerlMagick
	perl-module_src_prep
	perl-module_src_compile

}

src_install() {
	cd PerlMagick
	perl-module_src_install
}
