# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gtklp/gtklp-0.9m.ebuild,v 1.1 2002/10/22 17:19:20 seemant Exp $

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="A GUI for cupsd"
SRC_URI="http://www.stud.uni-hannover.de/~sirtobi/gtklp/files/${P}.src.tar.gz"
HOMEPAGE="http://www.stud.uni-hannover.de/~sirtobi/gtklp"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*
	>=net-print/cups-1.1.7"

RDEPEND="sys-devel/gettext"

src_compile() {
	elibtoolize

	local myconf
	
	# Upstream informs me that there are issues with disabling NLS, because
	# of gettext versions.
#	use nls \
#		&& myconf="${myconf} --enable-nls" \
#		|| myconf="${myconf} --disable-nls"

	use ssl \
		&& myconf="${myconf} --enable-ssl" \
		|| myconf="${myconf} --disable-ssl"

	econf ${myconf}
	make -f Makefile.fallback || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO KNOWN_BUGS
}
