# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pnet/pnet-0.5.4.ebuild,v 1.1 2003/04/19 20:34:36 cybersystem Exp $

# filter -march= since it breaks compile in cvm.c
inherit flag-o-matic
filter-flags "-march=*"

DESCRIPTION="Portable .NET runtime, compiler, tools"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu-pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=dev-util/treecc-0.2.4"

src_unpack() {
# A small patch which fixes compilation of pnetc-0.5.4

unpack ${A} ; cd ${S}/cscc/
epatch ${FILESDIR}/${P}.patch

}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README 
	dodoc doc/gtk-sharp.HOWTO doc/*html
}
