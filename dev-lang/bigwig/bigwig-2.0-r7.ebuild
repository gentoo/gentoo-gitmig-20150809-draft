# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/bigwig/bigwig-2.0-r7.ebuild,v 1.4 2003/04/16 17:54:31 cretin Exp $

IUSE="odbc mysql libwww java ssl"

DESCRIPTION="a high-level programming language for developing interactive Web services."
HOMEPAGE="http://www.brics.dk/bigwig/"
LICENSE="GPL-2"
DEPEND=">=net-www/apache-1.3
	odbc? ( dev-db/unixODBC )
	mysql? ( dev-db/mysql )
	libwww? ( net-libs/libwww )
	java? ( virtual/jre )
	ssl? ( dev-libs/openssl )
	sys-libs/zlib
	virtual/glibc"

SLOT="0"
SRC_URI="http://www.brics.dk/bigwig/dist/${P}-7.tar.gz"
KEYWORDS="x86"

S=${WORKDIR}/${P}

src_compile() {
	local myconf

	myconf="--enable-purify --enable-syslog=LOG_LOCAL5 --with-gnu-ld"
	myconf="${myconf} --with-apxs=/usr/sbin/apxs --with-apacheuser=apache --with-apachemodules=apache"

	use odbc \
		&& myconf="${myconf} --with-odbc-inc=/usr/include/ --with-odbc-lib=/usr/lib/" \
		|| myconf="${myconf} --disable-odbc"

	use libwww \
		&& myconf="${myconf} --with-libwww-config=/usr/bin/libwww-config" \
		|| myconf="${myconf} --disable-libwww"

	econf ${myconf} || die "./configure failed"
	#./configure \
	#	${myconf} \
	#	--host=${CHOST} \
	#	--prefix=/usr \
	#	--infodir=/usr/share/info \
	#	--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	local t
	for t in `find ${S} -type f -name Makefile`
	do
		cp ${t} ${t}.orig || die
		sed "s:^\(APACHE_.\+_DIR = \)\(/\):\1${D}\2:" ${t}.orig > ${t}
	done
	unset t

	make \
		DESTDIR=${D} \
		RPM_BUILD_ROOT=${D} \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		localstatedir=${D}/var/lib \
		install || die

	echo "make install finished"; echo

	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO

	rm -f ${D}/etc/apache/conf/httpd.conf

	# fix stupid install script...
	local t
	local tdst
	for t in `find ${D}${D} -type f -o -type l`
	do
		tdst=`echo ${t} | sed s:^${D}::`
		mkdir -p `dirname ${tdst}`
		mv ${t} ${tdst}
	done
	rm -rf ${D}/var/tmp/
}
