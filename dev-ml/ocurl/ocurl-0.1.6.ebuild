# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocurl/ocurl-0.1.6.ebuild,v 1.1 2005/03/08 23:49:23 mattam Exp $

inherit eutils findlib

DESCRIPTION="OCaml interface to the libcurl library"
HOMEPAGE="http://sourceforge.net/projects/ocurl"
LICENSE="MIT"
SRC_URI="mirror://sourceforge/ocurl/${P}.tgz"

SLOT="0"
IUSE="doc"

DEPEND=">=net-misc/curl-7.9.8
dev-libs/openssl"
RDEPEND="$DEPEND"
KEYWORDS="x86 ppc"

src_compile()
{
	epatch ${FILESDIR}/${PV}-curl-helper.patch
	econf --with-findlib || die
	make all || die
}

src_install()
{
	findlib_src_install
	dodoc COPYING
	use doc && dodoc examples/*.ml
}
