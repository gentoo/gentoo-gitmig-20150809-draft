# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lopster/lopster-1.2.0.ebuild,v 1.3 2003/06/12 22:32:27 seemant Exp $

IUSE="gtk nls"

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="A Napster Client using GTK"
HOMEPAGE="http://lopster.sourceforge.net"
SRC_URI="http://lopster.sourceforge.net/download/${P}.tar.gz
	http://lopster.sourceforge.net/download/${P}-1.patch.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="nls? ( sys-devel/gettext )"

EPATCH_SINGLE_MSG="patching transfer.c (fixes crash when being direct browsed)"

src_compile() {
	local myconf
	epatch ${DISTDIR}/lopster-1.2.0-1.patch.gz
	aclocal -I m4
	cp po/Makevars.template po/Makevars
	autoconf
	automake
	use nls || myconf="${myconf} --disable-nls"

	econf \
		--with-pthread \
		--with-zlib \
		${myconf}

	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS BUGS README ChangeLog NEWS TODO
}
