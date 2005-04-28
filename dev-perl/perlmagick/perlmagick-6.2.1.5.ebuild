# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perlmagick/perlmagick-6.2.1.5.ebuild,v 1.2 2005/04/28 21:48:55 mcummings Exp $

MY_PN=ImageMagick
MY_P=${MY_PN}-${PV%.*}
MY_P2=${MY_PN}-${PV%.*}-${PV#*.*.*.}

S=${WORKDIR}/${MY_P}
DESCRIPTION="A Perl module to harness the powers of ImageMagick"
HOMEPAGE="http://www.imagemagick.org/"
SRC_URI="mirror://sourceforge/imagemagick/${MY_P2}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~mips ~ppc64 ~ia64"
IUSE=""

#DEPEND="=media-gfx/imagemagick-${PV}*"

src_setup() {
	eerror "dev-perl/perlmagick is now part of imagemagick."
	eerror "You can enable perl things by perl USE flag."
	eerror "This package is obsolete and it'll be removed from portage soon"
	die "Remove dev-perl/perlmagick"
}
