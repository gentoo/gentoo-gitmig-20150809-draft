# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcrypt/libmcrypt-2.5.1-r4.ebuild,v 1.2 2002/08/01 18:02:36 seemant Exp $

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="libmcrypt is a library that provides uniform interface to access several encryption algorithms."
SRC_URI="ftp://mcrypt.hellug.gr/pub/mcrypt/libmcrypt/${P}.tar.gz"
HOMEPAGE="http://mcrypt.hellug.gr/"

DEPEND=">=sys-devel/automake-1.6.1
	>=sys-devel/libtool-1.4.1-r8"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

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
	autoreconf --force --install --symlink &>${T}/autoreconf.log || ( \
		echo "DEBUG: working directory is: `pwd`" >>${T}/autoreconf.log
		eerror "Reonfigure failed, please attatch the contents of:"
		eerror
		eerror "  ${T}/autoreconf.log"
		eerror
		eerror "in your bugreport."
		# we need an error here, else the ebuild do not die
		exit 1
	) || die "running autoreconf failed"
}

src_compile() {

	# Do not compile with -mcpu=k6/5 because of a k6/5 varible
	# in modules/algorithms/gosh.c
	CFLAGS="${CFLAGS/mcpu=k/march=k}"

	# Doesn't work with --host bug #3517
	econf --disable-posix-threads || die
		
	# PHP manual states to disable posix threads, no further explanation 
	# given, but i'll stick with it :)
	# (Source: http://www.php.net/manual/en/ref.mcrypt.php)

	emake || die
}

src_install () {
	
	dodir /usr/{bin,include,lib}
	
	einstall || die

	dodoc AUTHORS COPYING INSTALL KNOW-BUGS NEWS README THANKS TODO
	dodoc doc/README.* doc/example.c
}
