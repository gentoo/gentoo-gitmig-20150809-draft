# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/gsasl/gsasl-0.2.4.ebuild,v 1.1 2010/02/17 20:47:14 jer Exp $

EAPI="2"

DESCRIPTION="Virtual for the GNU SASL library"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="|| ( =net-libs/libgsasl-${PV} =net-misc/${P} )"
RDEPEND="${DEPEND}"
