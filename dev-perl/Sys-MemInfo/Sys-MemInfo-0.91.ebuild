# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-MemInfo/Sys-MemInfo-0.91.ebuild,v 1.6 2010/02/03 11:32:41 aballier Exp $

EAPI=2

MODULE_AUTHOR=SCRESTO
inherit perl-module

DESCRIPTION="Memory informations"

# sources specify LGPL-2.1, README "same terms as Perl itself"
LICENSE="LGPL-2.1 ${LICENSE}"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}"/${PN}
