# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/apache/apache-2.0.40-r1.ebuild,v 1.1 2002/09/13 08:48:17 carpaski Exp $

S="${WORKDIR}/httpd-${PV}"

KEYWORDS="x86"
DESCRIPTION="Apache Web Server, Version 2.0.x"
SRC_URI="http://www.apache.org/dist/httpd/httpd-${PV}.tar.gz"
HOMEPAGE="http://www.apache.org"
LICENSE="Apache-1.1"
SLOT="2"

DEPEND="virtual/glibc
	>=dev-libs/mm-1.1.3
	>=sys-libs/gdbm-1.8
	>=dev-libs/expat-1.95.2
	>=sys-devel/perl-5.6.1
	ssl? >=dev-libs/openssl-0.9.6e"

src_compile() {
	PREFIX=/usr/lib/apache2

	select_modules_config || die "determining modules" 
	./configure \
		--host=${CHOST} \
		--prefix=${PREFIX} \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/apache2 \
		--datadir=/home/httpd \
		--enable-suexec \
		--with-suexec-uidmin=1000 \
		--with-suexec-gidmin=100 \
		${MY_BUILTINS} \
			|| die "./configure failed"
	emake || die "Make failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"

	# Install documentation.
	dodoc CHANGES INSTALL LICENSE README

	insinto /etc/conf.d; newins ${FILESDIR}/${PV}/apache2.confd apache2
	exeinto /etc/init.d; newexe ${FILESDIR}/${PV}/apache2.initd apache2
	insinfo /etc/apache2; newins ${FILESDIR}/${PV}/apache2-builtin-mods
}

parse_modules_config() {
	local filename=$1
	local name=""
	local dso=""
	local disable=""
	[ -f ${filename} ] || return 1
	einfo ">>> using ${filename} for builtins..."
	for i in `cat $filename | sed "s/^#.*//"` ; do
		if [ $i == "-" ] ; then
			disable="true"
		elif [ -z "$name" ] && [ ! -z "`echo $i | grep "mod_"`" ] ; then
			name=`echo $i | sed "s/mod_//"`
		elif [ "$disable" ] && ( [ $i == "static" ] || [ $i == "shared" ] ) ; then
			MY_BUILTINS="${MY_BUILTINS} --disable-$name"
			name="" ; disable=""
		elif [ $i == "static" ] ; then
			MY_BUILTINS="${MY_BUILTINS} --enable-$name=yes"
			name="" ; disable=""
		elif [ $i == "shared" ] ; then
			MY_BUILTINS="${MY_BUILTINS} --enable-$name=shared"
			name="" ; disable=""
		fi
	done
	einfo ">>> Here is your custom config line:\n${MY_BUILTINS}"
}

select_modules_config() {
	parse_modules_config /etc/apache/apache2-builtin-mods || \
	parse_modules_config ${FILESDIR}/${PV}/apache2-builtin-mods || \
	return 1
}
