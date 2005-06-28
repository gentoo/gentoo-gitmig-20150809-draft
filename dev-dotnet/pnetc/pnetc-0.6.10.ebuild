# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pnetc/pnetc-0.6.10.ebuild,v 1.4 2005/06/28 21:50:04 iluxa Exp $

MY_P=${P/c/C}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Portable .NET C library"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu/pnet/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc ppc64 alpha arm hppa amd64 ia64"
IUSE=""

DEPEND="=dev-dotnet/pnetlib-${PV}*"

src_install() {
	einstall DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog INSTALL README doc/HACKING
}
