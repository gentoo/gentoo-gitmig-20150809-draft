# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-MemInfo/Sys-MemInfo-0.91.ebuild,v 1.3 2009/12/07 02:10:26 jer Exp $

EAPI=2

MODULE_AUTHOR=SCRESTO
inherit perl-module

DESCRIPTION="Memory informations"

# sources specify LGPL-2.1, README "same terms as Perl itself"
LICENSE="LGPL-2.1 ${LICENSE}"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

S="${WORKDIR}"/${PN}
