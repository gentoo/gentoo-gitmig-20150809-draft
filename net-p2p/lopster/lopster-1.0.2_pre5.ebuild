# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lopster/lopster-1.0.2_pre5.ebuild,v 1.5 2003/09/07 00:17:35 msterret Exp $

IUSE="nls"

MY_P=${P/2_pre/1-dev}
MY_P=${MY_P}.12
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Napster Client using GTK"
SRC_URI="http://lopster.sourceforge.net/download/${MY_P}.tar.gz"
HOMEPAGE="http://lopster.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	aclocal -I m4
	cp po/Makevars.template po/Makevars
	autoconf
	automake
#	cp configure.in configure.in.orig
#	sed -e "s:^intl/Makefile::" \
#		-e "s:AM_GNU_GETTEXT::" \
#		configure.in.orig > configure.in

#	cp Makefile.am Makefile.am.orig
#	sed "s:SUBDIR.*:SUBDIRS = m4 src:" \
#		Makefile.am.orig > Makefile.am

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
