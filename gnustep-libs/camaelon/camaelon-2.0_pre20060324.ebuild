# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/camaelon/camaelon-2.0_pre20060324.ebuild,v 1.1 2006/03/26 10:49:57 grobian Exp $

inherit gnustep

S=${WORKDIR}/${PN/c/C}

DESCRIPTION="Camaelon allows you to load theme bundles for GNUstep."

HOMEPAGE="http://www.etoile-project.org/etoile/mediawiki/index.php?title=Camaelon"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://www.roard.com/gnustep/Nesedah.theme.tgz
	http://brante.dyndns.org/gnustep/download/MaxCurve-0.2.tar.bz2
	mirror://sourceforge/mpdcon/IndustrialTheme.tar.bz2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
SLOT="0"
LICENSE="LGPL-2.1"

IUSE=""
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "Local"

src_install() {
	gnustep_src_install || die "install failed"

	# install themes
	mkdir -p "${D}$(egnustep_system_root)/Library/Themes"
	cp -R "${WORKDIR}/"*theme "${D}$(egnustep_system_root)/Library/Themes/"
}
