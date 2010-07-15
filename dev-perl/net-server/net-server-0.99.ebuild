# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-server/net-server-0.99.ebuild,v 1.1 2010/07/15 13:50:41 tove Exp $

EAPI=3

MODULE_AUTHOR=RHANDOM
MY_PN=Net-Server
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Extensible, general Perl server engine"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-perl/IO-Multiplex"
DEPEND="${RDEPEND}"

SRC_TEST="do"
