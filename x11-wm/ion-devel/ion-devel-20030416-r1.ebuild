# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion-devel/ion-devel-20030416-r1.ebuild,v 1.1 2003/04/24 19:02:04 twp Exp $

MY_P=${PN}-${PV/_p/-}
DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
SRC_URI="http://modeemi.fi/~tuomov/dl/${MY_P}.tar.gz"
LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="truetype xinerama"
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
		-e 's:^#\(LUA_LIBS = -llua -llualib\):\1:' \
		-e 's:^#\(LUA_INCLUDES =\):\1:' \
		-e '/^LUA_PATH=\/usr\/local\/lib/d' \
		-e '/^LUA_LIBS = -L$(LUA_PATH) -R$(LUA_PATH) -llua -llualib/d' \
		-e '/^LUA_INCLUDES = -I$(LUA_PATH)\/include/d' \
		-e 's:^#\(DEFINES += -DCF_UTF8 -DCF_ICONV_TARGET=\\"WCHAR_T\\" -DCF_ICONV_SOURCE=\\"UTF-8\\"\):\1:' \
		-e 's:^#\(HAS_SYSTEM_ASPRINTF=1\):\1:' \
		-e 's:#\(XOPEN_SOURCE=-ansi -D_XOPEN_SOURCE -D_XOPEN_SOURCE_EXTENDED\):\1:' \
		-e "s:^\\(CFLAGS=\\)-g -O2\\(\$(WARN) \$(DEFINES) \$(INCLUDES) \$(EXTRA_INCLUDES)\\):\\1${CFLAGS}\\2:" \
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
		sed -e 's:#\(DEFINES += -DCF_XFT\):\1:' \
			-e "s:#\\(X11_INCLUDES += \\)\`xft-config --cflags\`:\\1${xft_cflags}:" \
			-e "s:#\\(X11_LIBS += \\)\`xft-config --libs\`:\\1${xft_libs}:" \
			system.mk.orig > system.mk
	fi

	if [ -z "`use xinerma`" ]; then
		cp system.mk system.mk.orig
		sed -e '/XINERAMA_LIBS=-lXinerma/d' \
			-e 's:#\(DEFINES += CF_NO_XINERAMA\):\1:' \
			system.mk.orig > system.mk
	fi
	
	cp Makefile Makefile.orig
	sed -e "s:\$(DOCDIR)/ion:\$(DOCDIR)/${PF}:" \
		Makefile.orig > Makefile

	emake || die

}

src_install() {
	make PREFIX=${D}/usr ETCDIR=${D}/etc/X11 install || die
	echo -n "#!/bin/sh\n/usr/bin/ion" > ion-devel
	exeinto /etc/X11/Sessions
	doexe ion-devel
}
