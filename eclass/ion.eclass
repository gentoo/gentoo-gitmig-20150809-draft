# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/ion.eclass,v 1.3 2003/07/18 20:17:44 vapier Exp $

ECLASS=ion
INHERITED="${INHERITED} ${ECLASS}"

IUSE="${IUSE} truetype"
SRC_URI="${SRC_URI} http://modeemi.cs.tut.fi/~tuomov/dl/ion-devel-${ION_VERSION}.tar.gz"
DEPEND="${DEPEND}
	virtual/glibc
	virtual/x11
	truetype? ( virtual/xft )"

ion_src_configure() {

	if [ -n "$1" ]; then
		echo ">>> Configuring Ion in $1..."
		local wd=`pwd`
		cd $1
	else
		echo ">>> Configuring Ion..."
	fi

	cp system.mk system.mk.orig
	sed -e 's:^PREFIX=/usr/local/ion-devel:PREFIX=/usr:' \
		-e 's:^ETCDIR=$(PREFIX)/etc:ETCDIR=/etc/X11:' \
		-e 's:^MANDIR=$(PREFIX)/man:MANDIR=$(PREFIX)/share/man:' \
		-e 's:^DOCDIR=$(PREFIX)/doc:DOCDIR=$(PREFIX)/share/doc:' \
		-e 's:^#DEFINES += -DCF_UTF8 -DCF_ICONV_TARGET=\\"WCHAR_T\\" -DCF_ICONV_SOURCE=\\"UTF-8\\":DEFINES += -DCF_UTF8 -DCF_ICONV_TARGET=\\"WCHAR_T\\" -DCF_ICONV_SOURCE=\\"UTF-8\\":' \
		-e 's:^#HAS_SYSTEM_ASPRINTF=1:HAS_SYSTEM_ASPRINTF=1:' \
		-e 's:#XOPEN_SOURCE=-ansi -D_XOPEN_SOURCE -D_XOPEN_SOURCE_EXTENDED:XOPEN_SOURCE=-ansi -D_XOPEN_SOURCE -D_XOPEN_SOURCE_EXTENDED:' \
		-e "s:^CFLAGS=-g -O2 \$(WARN) \$(DEFINES) \$(INCLUDES) \$(EXTRA_INCLUDES):CFLAGS=${CFLAGS} \$(WARN) \$(DEFINES) \$(INCLUDES) \$(EXTRA_INCLUDES):" \
		system.mk.orig > system.mk
	
	local ion_version=`cut -d\  -f3 version.h | tr -d \"`
	cp Makefile Makefile.orig
	sed -e "s:\$(DOCDIR)/ion:\$(DOCDIR)/ion-devel-${ion_version}:" \
		Makefile.orig > Makefile

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

	echo ">>> Ion configured."

	if [ -n "$1" ]; then
		cd ${wd}
	fi

}

EXPORT_FUNCTIONS src_configure
