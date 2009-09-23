# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/libspf2/libspf2-1.2.8.ebuild,v 1.10 2009/09/23 17:54:31 patrick Exp $

inherit eutils

DESCRIPTION="libspf2 implements the Sender Policy Framework, a part of the SPF/SRS protocol pair."
HOMEPAGE="http://www.libspf2.org"
SRC_URI="http://www.libspf2.org/spf/libspf2-${PV}.tar.gz"

LICENSE="|| ( LGPL-2.1 BSD-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=""
RDEPEND="!dev-perl/Mail-SPF-Query"

RESTRICT="test"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc README TODO docs/*.txt docs/API
}
