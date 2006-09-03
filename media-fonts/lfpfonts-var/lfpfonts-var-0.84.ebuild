# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/lfpfonts-var/lfpfonts-var-0.84.ebuild,v 1.8 2006/09/03 06:41:22 vapier Exp $

inherit font

DESCRIPTION="Linux Font Project variable-width fonts"
HOMEPAGE="http://sourceforge.net/projects/xfonts/"
SRC_URI="mirror://sourceforge/xfonts/${PN}-src-${PV}.tar.bz2"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc s390 sh sparc x86"
IUSE=""

S=${WORKDIR}/${PN}-src

FONT_SUFFIX="pcf.gz"

FONT_S=${S}/lfp-var

DOCS="doc/*"

src_compile() {
	cd ${S}/src

	PATH=".:${PATH}" ./compile || die "converting BDF fonts to PCF failed"
}
