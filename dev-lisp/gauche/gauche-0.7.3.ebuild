# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gauche/gauche-0.7.3.ebuild,v 1.2 2004/02/04 13:24:03 hattya Exp $

inherit flag-o-matic

# 2003-09-06: karltk
# Original submission used the non-exisiting utf8 flag, changed to nls for now
IUSE="ipv6 nls"
HOMEPAGE="http://gauche.sf.net"
DESCRIPTION="A Unix system friendly Scheme Interpreter"
SRC_URI="mirror://sourceforge/gauche/Gauche-${PV}.tgz"
LICENSE="BSD"
KEYWORDS="~x86 ~sparc"
SLOT="0"
S="${WORKDIR}/Gauche-${PV}"

DEPEND=">=sys-libs/gdbm-1.8.0-r5"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-gdbm-gentoo.diff
	autoconf
}

src_compile() {
	local myconf mycflags

	use ipv6 && myconf="--enable-ipv6"

	if [ "`use nls`" ]; then
		myconf="$myconf --enable-multibyte=utf-8"
	else
		myconf="$myconf --enable-multibyte=euc-jp"
	fi

	sed -e "67s/\$(LIB_INSTALL_DIR)/\$(DISTDIR)\$(LIB_INSTALL_DIR)/" \
		src/Makefile.in > src/Makefile.in.tmp
	rm -f src/Makefile.in
	mv src/Makefile.in.tmp src/Makefile.in

	filter-flags -fforce-addr

	mycflags=${CFLAGS}
	unset CFLAGS CXXFLAGS

	econf ${myconf} --enable-threads=pthreads || die
	emake OPTFLAGS="${mycflags}" || die

	make -s check || die
}

src_install () {

	make install DESTDIR=${D} || die

	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL INSTALL.eucjp README
}
