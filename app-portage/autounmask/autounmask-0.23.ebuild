# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/autounmask/autounmask-0.23.ebuild,v 1.4 2009/01/06 00:17:27 cla Exp $

DESCRIPTION="autounmask - Unmasking packages the easy way"
HOMEPAGE="http://download.mpsna.de/opensource/autounmask/"
SRC_URI="http://download.mpsna.de/opensource/autounmask/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ia64 ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl
		>=dev-perl/PortageXS-0.02.09
		virtual/perl-Term-ANSIColor
		dev-perl/Shell-EnvImporter"
RDEPEND="${DEPEND}
		sys-apps/portage"

src_install() {
	dobin autounmask || die
	dodoc Changelog
}
