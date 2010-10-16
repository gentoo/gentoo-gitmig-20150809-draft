# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/gsasl/gsasl-1.4.1.ebuild,v 1.4 2010/10/16 12:11:23 ranger Exp $

EAPI="2"

DESCRIPTION="Virtual for the GNU SASL library"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="|| ( =net-libs/libgsasl-${PV} =net-misc/${P} )"
RDEPEND="${DEPEND}"
