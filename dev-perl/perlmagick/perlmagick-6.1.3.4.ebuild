# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perlmagick/perlmagick-6.1.3.4.ebuild,v 1.3 2004/11/28 00:14:36 hardave Exp $

inherit perl-module eutils

# Left this the same as ImageMagick for the sake of simplicity
MY_PN=ImageMagick
MY_P=${MY_PN}-${PV%.*}
MY_P2=${MY_PN}-${PV%.*}-${PV#*.*.*.}

S=${WORKDIR}/${MY_P}
DESCRIPTION="A Perl module to harness the powers of ImageMagick"
HOMEPAGE="http://www.imagemagick.org/"
SRC_URI="mirror://sourceforge/imagemagick/${MY_P2}.tar.bz2"

# 2004.09.06 rac
# i think this license needs changing, as does imagemagick. the
# website says "an apache-style license".
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 mips ppc64 ~ia64"
IUSE=""

DEPEND="=media-gfx/imagemagick-${PV}*
	>=dev-lang/perl-5"

src_compile() {
	cd PerlMagick
	perl-module_src_prep
	perl-module_src_compile
}

src_install() {
	cd PerlMagick
	perl-module_src_install
}
