# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pretrace/pretrace-0.1.ebuild,v 1.1 2005/04/06 12:16:19 taviso Exp $

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Start dynamically linked applications under debugging environment"
HOMEPAGE="http://dev.gentoo.org/~taviso/files/libpretrace.c"
SRC_URI="${HOMEPAGE}.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"
DEPEND="virtual/libc"
S=${WORKDIR}

src_compile() {
	use debug && append-flags -DDEBUG

	ebegin "[CC] ${A//.gz/} => libpretrace.so"
			$(tc-getCC) ${CFLAGS} ${ASFLAGS} ${LDFLAGS} -shared \
				-o ${S}/libpretrace.so ${S}/${A//.gz/} || {
					eend 1
					die "compile failed"
			}
	eend 0

	ebegin "[DOC] => pretrace.conf.example"
cat << EOF > ${T}/pretrace.conf.example
# example pretrace configuration file
# 	/etc/pretrace.conf

# application[:/full/path/to/debugger [arg1 arg2 ...]]

ls:/usr/bin/strace -f -efile -o/home/user/ls.logfile
fetchmail:/usr/bin/ltrace -f
xcalc:/usr/bin/valgrind --tool=memcheck --trace-children=yes --log-file=xcalc
xterm
EOF
	eend $?
	ebegin "[DOC] => README"
cat << EOF > ${T}/README
libpretrace is a preload library that allows specified (dynamically linked)
applications to always be executed under a debugging environment. To start
using pretrace, add libpretrace.so to your /etc/ld.so.preload.

	root# echo /usr/$(get_libdir)/libpretrace.so >> /etc/ld.so.preload

You can now specify applications to trace in /etc/pretrace.conf, the format
is one application per line, if you would like to specify a debugger append
a colon, then the full path to the debugger and any arguments you would like
to pass. If you do not specify a debugger, you get the default, strace, which
saves the output to .logfile in the current working directory.

# this is a comment
application[:/full/path/to/debugger [arg1 arg2 ...]]

An example pretrace.conf is provided with this distribution.

libpretrace is designed as a debugging utility for developers and auditors,
and should not be used in a production environment.

libpretrace is released under GPL version 2, and was created by Rob Holland
and Tavis Ormandy of the Gentoo Linux Security Audit Team.

taviso@gentoo.org
tigger@gentoo.org

April, 2005.
EOF
	eend $?
}

src_install() {
	dolib.so libpretrace.so
	dodoc ${T}/pretrace.conf.example ${T}/README
}

pkg_postinst() {
	einfo "To use pretrace, please add /usr/$(get_libdir)/libpretrace.so to /etc/ld.so.preload."
	einfo "Please see documentation for the configuration file format and more information."
}
