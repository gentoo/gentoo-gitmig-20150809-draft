# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/autobook/autobook-1.3.ebuild,v 1.7 2004/12/20 02:33:05 jhuebel Exp $

DESCRIPTION="GNU Autoconf, Automake and Libtool"
HOMEPAGE="http://sources.redhat.com/autobook/"
SRC_URI="http://sources.redhat.com/autobook/${P}.tar.gz"

LICENSE="OPL"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""
DEPEND=""

src_install() {
	dohtml *
}
