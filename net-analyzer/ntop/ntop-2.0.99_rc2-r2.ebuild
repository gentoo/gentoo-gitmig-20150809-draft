# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ntop/ntop-2.0.99_rc2-r2.ebuild,v 1.4 2002/08/14 12:12:28 murphy Exp $

S=${WORKDIR}/RC2/ntop
DESCRIPTION="ntop is a unix tool that shows network usage like top"
SRC_URI="http://luca.ntop.org/${P/_/-}.tgz"
HOMEPAGE="http://www.ntop.org/ntop.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND=">=sys-libs/gdbm-1.8.0
	>=net-libs/libpcap-0.5.2
	>=sys-apps/tcp-wrappers-7.6
	ssl? ( >=dev-libs/openssl-0.9.6 )
	mysql? ( dev-db/mysql )
	readline? ( >=sys-libs/readline-4.1 )"
#	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
# Disabling tcp-wrappers seems to be b0rken (see bug #4678),
# so I made this a requirement for now. --blizzy

RDEPEND="${DEPEND}"

src_compile() {
	local myconf
	if [ -z "`use ssl`" ] ; then
		myconf="--disable-ssl"
	else
		cp configure configure.orig
		sed -e "s:/usr/local/ssl:/usr:" configure.orig > configure
		export CFLAGS="$CFLAGS -I/usr/include/openssl"
	fi

	use mysql	|| myconf="${myconf} --disable-mysql"
	use readline	|| myconf="${myconf} --disable-readline"
# see above --blizzy
#	use tcpd	|| myconf="${myconf} --enable-tcpwrap"
	myconf="${myconf} --enable-tcpwrap"

	# ntop 2.0 ships with its own version of gdchart... gdchart should
	# get its own package but ntop should be built with the version it
	# shipped with just in case future versions are incompatible -- blocke

	# compile gdchart
	cd ../gdchart0.94c
	./configure || die "gdchart configure problem"

	# subtree #1
	cd gd-1.8.3/libpng-1.2.1
	make -f scripts/makefile.linux || die "libpng compile problem"

	# subtree #2
	cd ../../zlib-1.1.4/
	./configure || die "zlib configure problem"
	make || die "zlib compile problem"

	# gdchart make
	cd ../
	make || die "gdchart compile problem"

	# now ntop itself...
	cd ../ntop
	patch -p0 -i ${FILESDIR}/tcpwrap.patch
	econf ${myconf} || die "configure problem"
	make || die "compile problem"
}

src_install () {
	# slight issue with man file installation
	mv Makefile Makefile.orig
	sed 's/man_MANS = ntop.8 intop\/intop.1//g' Makefile.orig > Makefile

	make \
		prefix=${D}/usr \
		sysconfdir=/${D}/etc \
		mandir=${D}/usr/share/man \
		datadir=${D}/usr/share \
		DATAFILE_DIR=${D}/usr/share/ntop \
		CONFIGFILE_DIR=${D}/etc/ntop \
		install || die "install problem"

	# fixme: bad handling of plugins (in /usr/lib with unsuggestive names)
	# (don't know if there is a clean way to handle it)

	doman ntop-rules.8 ntop.8

	dodoc AUTHORS CONTENTS COPYING ChangeLog MANIFESTO NEWS
	dodoc PORTING README SUPPORT_NTOP.txt THANKS

	dohtml ntop.html

	dodir /var/lib/ntop
}
