# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perlmagick/perlmagick-5.5.6.ebuild,v 1.1 2003/04/24 15:30:32 darkspecter Exp $

inherit perl-module
inherit flag-o-matic
replace-flags k6-3 i586
replace-flags k6-2 i586  
replace-flags k6 i586  

IUSE=""

# Left this the same as ImageMagick for the sake of simplicity
MY_PN=ImageMagick

### PV magic not needed as we dont have a patchlevel yet
#MY_P=${MY_PN}-${PV%.*}-${PV#*.*.*.}
#MY_P2=${MY_PN}-${PV%.*}
MY_P=${MY_PN}-${PV}
MY_P2=${MY_PN}-${PV}

S=${WORKDIR}/${MY_P2}
DESCRIPTION="A Perl module to harness the powers of ImageMagick"
SRC_URI="mirror://sourceforge/imagemagick/${MY_P}.tar.gz"
HOMEPAGE="http://www.imagemagick.org/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc ~sparc ~alpha ~mips ~hppa"

DEPEND="=media-gfx/imagemagick-${PV}
		>=dev-lang/perl-5"

src_compile() {
	#patch to allow building by perl
	patch -p0 < ${FILESDIR}/perlpatch.diff
	
	cd PerlMagick
	perl-module_src_prep
	perl-module_src_compile

}

src_install() {
	cd PerlMagick
	perl-module_src_install
}
