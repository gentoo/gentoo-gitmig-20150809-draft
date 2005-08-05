# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pnetc/pnetc-0.6.10.ebuild,v 1.5 2005/08/05 14:26:49 ferdy Exp $

MY_P=${P/c/C}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Portable .NET C library"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu/pnet/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ppc ppc64 x86"
IUSE=""

DEPEND="=dev-dotnet/pnetlib-${PV}*"

src_install() {
	einstall DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog INSTALL README doc/HACKING
}
