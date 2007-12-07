# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/gsldap/gsldap-0.0.1_pre20070219.ebuild,v 1.1 2007/12/07 19:16:11 voyageur Exp $

inherit gnustep-2

DESCRIPTION="GNUstep LDAP library for open ldap C libraries"
HOMEPAGE="http://www.gnustep.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="net-nds/openldap"
RDEPEND="${DEPEND}"
