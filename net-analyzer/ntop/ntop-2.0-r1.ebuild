# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ntop/ntop-2.0-r1.ebuild,v 1.4 2002/07/11 06:30:45 drobbins Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="ntop is a unix tool that shows network usage like top"
SRC_URI="http://luca.ntop.org/${P}-src.tgz"
HOMEPAGE="http://www.ntop.org/ntop.html"

DEPEND="virtual/glibc sys-devel/gcc
	>=sys-libs/gdbm-1.8.0
	>=net-libs/libpcap-0.5.2
	ssl? ( >=dev-libs/openssl-0.9.6 )
	mysql? ( dev-db/mysql )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	readline? ( >=sys-libs/readline-4.1 )"

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

    use mysql		|| myconf="${myconf} --disable-mysql"
    use readline	|| myconf="${myconf} --disable-readline"
    use tcpd		|| myconf="${myconf} --enable-tcpwrap"

    # ntop 2.0 ships with its own version of gdchart... gdchart should
    # get its own package but ntop should be built with the version it
    # shipped with just in case future versions are incompatible -- blocke

    # compile gdchart
    cd ../gdchart0.94c
    ./configure || die

    # subtree #1
    cd gd-1.8.3/libpng-1.0.8
    make -f scripts/makefile.linux || die

    # subtree #2
    cd ../../zlib-1.1.3/
    ./configure || die
    make || die

    # gdchart make
    cd ../
    make || die

    # now ntop itself...
    cd ../ntop
    # fix syslog() format strings vulnerability.
    patch -p1 < ${FILESDIR}/ntop-2.0_syslog_format.patch
	econf ${myconf} || die
    make || die

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
		install || die

    # fixme: bad handling of plugins (in /usr/lib with unsuggestive names)
    # (don't know if there is a clean way to handle it)

    doman ntop-rules.8 ntop.8

    dodoc AUTHORS CONTENTS COPYING ChangeLog INSTALL MANIFESTO NEWS
    dodoc PORTING README SUPPORT_NTOP.txt THANKS

    dohtml ntop.html
}
