# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcrypt/libmcrypt-2.5.5.ebuild,v 1.7 2004/01/24 08:23:59 robbat2 Exp $

#inherit libtool

DESCRIPTION="libmcrypt is a library that provides uniform interface to access several encryption algorithms."
HOMEPAGE="http://mcrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mcrypt/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc ppc hppa alpha"

DEPEND=">=sys-devel/automake-1.6.1
	>=sys-devel/libtool-1.4.1-r8"

src_unpack() {
	unpack ${A}

	cd ${S}
	# This is also fixes for bug #3940.  The included libltdl gives some
	# errors during ./configure
	rm -rf ${S}/libltdl
	rm -f ${S}/config.{guess,status,sub}
	libtoolize --ltdl --copy --force

	# Try to fix some wierd build problems. See bug #3940.
	echo ">>> Reconfiguring package..."
	export WANT_AUTOMAKE_1_6=1
	export WANT_AUTOCONF_2_5=1
	autoreconf --force --install --symlink &>${T}/autoreconf.log || {
		echo "DEBUG: working directory is: `pwd`" >>${T}/autoreconf.log
		eerror "Reonfigure failed, please attatch the contents of:"
		eerror
		eerror "  ${T}/autoreconf.log"
		eerror
		eerror "in your bugreport."
		die "running autoreconf failed"
	}
}

src_compile() {
	# PHP manual states to disable posix threads, no further explanation
	# given, but i'll stick with it :)
	# (Source: http://www.php.net/manual/en/ref.mcrypt.php)
	# Doesn't work with --host bug #3517
	econf --disable-posix-threads || die
	emake || die
}

src_install() {
	dodir /usr/{bin,include,lib}
	einstall || die

	dodoc AUTHORS COPYING COPYING.LIB INSTALL NEWS README THANKS TODO
	dodoc doc/README.* doc/example.c
}
