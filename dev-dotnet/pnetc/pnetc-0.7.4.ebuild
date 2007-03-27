# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pnetc/pnetc-0.7.4.ebuild,v 1.7 2007/03/27 14:09:07 armin76 Exp $

MY_P=${P/c/C}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Portable.NET C library"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="http://www.southern-storm.com.au/download/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ia64 ppc x86"
IUSE="examples"

DEPEND="=dev-dotnet/pnetlib-${PV}*"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README doc/HACKING

	if use examples ; then
		docinto examples
		dodoc samples/*.c
	fi
}
