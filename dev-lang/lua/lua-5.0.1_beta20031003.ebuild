# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/lua/lua-5.0.1_beta20031003.ebuild,v 1.2 2003/12/20 00:12:53 gmsoft Exp $

DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="http://www.lua.org/"
SRC_URI="http://www.lua.org/ftp/lua-5.0.tar.gz
	http://www.tecgraf.puc-rio.br/lua/work/lua-5.0-update.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc ~x86"
DEPEND="virtual/glibc
	>=sys-apps/sed-4"
S=${WORKDIR}/lua-5.0.1

src_unpack() {
	unpack lua-5.0.tar.gz || die
	mv lua-5.0 lua-5.0.1 || die
	unpack lua-5.0-update.tar.gz || die

	cd "${S}"
	
	epatch "${FILESDIR}/lua-5.0.1-pic.patch"
	
	sed -i \
		-e 's:^#POPEN= -DUSE_POPEN$:POPEN= -DUSE_POPEN:' \
		-e "s:^MYCFLAGS= -O2:MYCFLAGS= ${CFLAGS}:" \
		-e 's:INSTALL_ROOT= /usr/local:INSTALL_ROOT= $(DESTDIR)/usr:' \
		-e 's:INSTALL_MAN= $(INSTALL_ROOT)/man/man1:INSTALL_MAN= $(INSTALL_ROOT)/share/man/man1:' \
		config || die "sed config failed"

}

src_compile() {

	export PICFLAGS=-fPIC
	
	emake || die "emake failed"
	emake so || die "emake so failed"
}

src_install() {
	make DESTDIR=${D} install soinstall || die "make install soinstall failed"
	dodoc COPYRIGHT HISTORY README
	dohtml doc/*.html doc/*.gif
}
