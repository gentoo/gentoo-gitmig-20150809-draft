# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/lua/lua-5.0_beta.ebuild,v 1.3 2004/01/03 10:22:10 avenj Exp $

MY_P=`echo ${P} | sed -e 's/_beta/-beta/'`
DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="http://www.lua.org/"
SRC_URI="http://www.lua.org/ftp/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/glibc"
S=${WORKDIR}/${MY_P}

src_compile() {
	cp config config.orig
	sed -e 's:^#POPEN= -DUSE_POPEN$:POPEN= -DUSE_POPEN:' \
		-e "s:^MYCFLAGS= -O2:MYCFLAGS= ${CFLAGS}:" \
		-e 's:INSTALL_ROOT= /usr/local:INSTALL_ROOT= $(DESTDIR)/usr:' \
		-e 's:INSTALL_MAN= $(INSTALL_ROOT)/man/man1:INSTALL_MAN= $(INSTALL_ROOT)/share/man/man1:' \
		config.orig > config
	emake || die
	emake so || die
}

src_install() {
	make DESTDIR=${D} install soinstall || die
	dodoc COPYRIGHT HISTORY README
	dohtml doc/*.html doc/*.gif
}
