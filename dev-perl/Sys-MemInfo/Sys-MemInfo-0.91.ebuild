# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-MemInfo/Sys-MemInfo-0.91.ebuild,v 1.4 2009/12/26 19:02:53 armin76 Exp $

EAPI=2

MODULE_AUTHOR=SCRESTO
inherit perl-module

DESCRIPTION="Memory informations"

# sources specify LGPL-2.1, README "same terms as Perl itself"
LICENSE="LGPL-2.1 ${LICENSE}"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~sparc ~x86"
IUSE=""

S="${WORKDIR}"/${PN}
