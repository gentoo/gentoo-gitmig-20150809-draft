# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/bigloo-lib/bigloo-lib-0.17.ebuild,v 1.1 2004/02/11 22:49:41 jake Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Bigloo support libraries"
SRC_URI="mirror://sourceforge/bigloo-lib/${P}.tar.gz"
HOMEPAGE="http://bigloo-lib.sf.net"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc "
IUSE="nls gtk postgres mysql gtk2 ipcs gd ldap X gdbm expat"

DEPEND=">=dev-scheme/bigloo-2.4
	X? ( virtual/x11 )
	gd? ( >=media-libs/libgd-1.8.3 )
	gtk? ( =x11-libs/gtk+-1.2* )
	nls? ( >=sys-devel/gettext-0.11.1 )
	gtk2? ( =x11-libs/gtk+-2* )
	ldap? ( >=net-nds/openldap-2.0.18 )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	>=dev-libs/expat-1.95.4
	"
src_compile() {
	local myconf
	# readline support is flaky
#	myconf="--with-commandline"	
	use gd && \
		myconf="${myconf} --with-gd" \
		|| myconf="${myconf} --without-gd"

	use X \
		&& myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

	use gtk \
		&& myconf="${myconf} --with-gtk" \
		|| myconf="${myconf} --without-gtk"

	use gtk2 \
		&& myconf="${myconf} --with-gtk2" \
		|| myconf="${myconf} --without-gtk2"

	use ldap \
		&& myconf="${myconf} --with-ldap" \
		|| myconf="${myconf} --without-ldap"

	use nls \
		&& myconf="${myconf} --with-iconv --with-gettext" \
		|| myconf="${myconf} --without-nls --without-gettext"

	# gdbm support doesn't work
#	use gdbm \
#		&& myconf="${myconf} --with-gdbm" \
#		|| myconf="${myconf} --without-gdbm"
	myconf="${myconf} --without-gdbm"

	use mysql \
		&& myconf="${myconf} --with-mysql" \
		|| myconf="${myconf} --without-mysql"

	use postgres \
		&& myconf="${myconf} --with-postgres" \
		|| myconf="${myconf} --without-postgres"

#	We just force these, as we don't have useflags for them.
#	use expat \
#		&& myconf="${myconf} --with-expat" \
#		|| myconf="${myconf} --without-expat"
#	use ipcs \
#		&& myconf="${myconf} --with-ipcs" \
#		|| myconf="${myconf} --without-ipcs"


	myconf="${myconf} --with-expat --with-ipcs"


	econf ${myconf} || die "./configure failed"
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
}
