# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/NetAddr-IP/NetAddr-IP-4.033.ebuild,v 1.1 2010/09/30 18:59:31 robbat2 Exp $

EAPI=3

MODULE_AUTHOR="MIKER"
inherit perl-module

DESCRIPTION="Manipulation and operations on IP addresses"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ipv6"

RDEPEND="ipv6? ( dev-perl/Socket6 )"
DEPEND="${RDEPEND}"

SRC_TEST="do"

src_prepare() {
	perl-module_src_prepare
	touch "${S}"/Makefile.old
}
