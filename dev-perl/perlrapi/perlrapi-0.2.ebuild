# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perlrapi/perlrapi-0.2.ebuild,v 1.10 2006/07/05 19:09:16 ian Exp $

inherit perl-module

IUSE=""

S=${WORKDIR}/perlrapi

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync. - PERL bindings"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 x86"

DEPEND="virtual/libc
	app-pda/synce-librapi2"
RDEPEND="${DEPEND}"