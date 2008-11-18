# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/autounmask/autounmask-0.21.ebuild,v 1.10 2008/11/18 15:57:01 tove Exp $

DESCRIPTION="autounmask - Unmasking packages the easy way"
HOMEPAGE="http://download.mpsna.de/opensource/autounmask/"
SRC_URI="http://download.mpsna.de/opensource/autounmask/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl
		>=dev-perl/PortageXS-0.02.07
		virtual/perl-Term-ANSIColor
		dev-perl/Shell-EnvImporter"
RDEPEND="${DEPEND}
		sys-apps/portage"

src_install() {
	dobin autounmask || die
	dodoc Changelog
}
