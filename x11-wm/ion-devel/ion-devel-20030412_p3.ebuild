# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion-devel/ion-devel-20030412_p3.ebuild,v 1.1 2003/04/14 17:57:36 twp Exp $

MY_P=${PN}-`echo ${PV} | sed s:_p:-:`
DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
SRC_URI="http://modeemi.fi/~tuomov/dl/${MY_P}.tar.gz"
LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="truetype"
DEPEND="virtual/glibc
	app-misc/run-mailcap
	>=dev-lang/lua-5
	dev-lang/perl
	truetype? ( virtual/xft )"
S=${WORKDIR}/${MY_P}

src_compile() {

	cp system.mk system.mk.orig
	sed -e 's:^PREFIX=/usr/local/ion-devel:PREFIX=/usr:' \
		-e 's:^ETCDIR=$(PREFIX)/etc:ETCDIR=/etc/X11:' \
		-e 's:^MANDIR=$(PREFIX)/man:MANDIR=$(PREFIX)/share/man:' \
		-e 's:^DOCDIR=$(PREFIX)/doc:DOCDIR=$(PREFIX)/share/doc:' \
		-e 's:^#LUA_LIBS = -llua -llualib:LUA_LIBS = -llua -llualib:' \
		-e 's:^#LUA_INCLUDES =:LUA_INCLUDES =:' \
		-e '/^LUA_PATH=\/usr\/local\/lib/d' \
		-e '/^LUA_LIBS = -L$(LUA_PATH) -R$(LUA_PATH) -llua -llualib/d' \
		-e '/^LUA_INCLUDES = -I$(LUA_PATH)\/include/d' \
		-e 's:^#DEFINES += -DCF_UTF8 -DCF_ICONV_TARGET=\\"WCHAR_T\\" -DCF_ICONV_SOURCE=\\"UTF-8\\":DEFINES += -DCF_UTF8 -DCF_ICONV_TARGET=\\"WCHAR_T\\" -DCF_ICONV_SOURCE=\\"UTF-8\\":' \
		-e 's:^#HAS_SYSTEM_ASPRINTF=1:HAS_SYSTEM_ASPRINTF=1:' \
		-e 's:#XOPEN_SOURCE=-ansi -D_XOPEN_SOURCE -D_XOPEN_SOURCE_EXTENDED:XOPEN_SOURCE=-ansi -D_XOPEN_SOURCE -D_XOPEN_SOURCE_EXTENDED:' \
		-e "s:^CFLAGS=-g -O2 \$(WARN) \$(DEFINES) \$(INCLUDES) \$(EXTRA_INCLUDES):CFLAGS=${CFLAGS} \$(WARN) \$(DEFINES) \$(INCLUDES) \$(EXTRA_INCLUDES):" \
		system.mk.orig > system.mk

	if [ "`use truetype`" ]; then
		local xft_config=`which xft-config 2> /dev/null`
		if [ -n "${xft_config}" ] && [ -x "${xft_config}" ]; then
			local xft_cflags=`${xft_config} --cflags`
			local xft_libs=`${xft_config} --libs`
		else
			local xft_cflags=
			local xft_libs="-lXft"
		fi
		cp system.mk system.mk.orig
		sed -e 's:#DEFINES += -DCF_XFT:DEFINES += -DCF_XFT:' \
			-e "s:#X11_INCLUDES += \`xft-config --cflags\`:X11_INCLUDES += ${xft_cflags}:" \
			-e "s:#X11_LIBS += \`xft-config --libs\`:X11_LIBS += ${xft_libs}:" \
			system.mk.orig > system.mk
	fi
	
	cp Makefile Makefile.orig
	sed -e "s:\$(DOCDIR)/ion:\$(DOCDIR)/${P}:" \
		Makefile.orig > Makefile

	emake || die

}

src_install() {
	make PREFIX=${D}/usr ETCDIR=${D}/etc/X11 install || die
	echo -n "#!/bin/sh\n/usr/bin/ion" > ion-devel
	exeinto /etc/X11/Sessions
	doexe ion-devel
}
