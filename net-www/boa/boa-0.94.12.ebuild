# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/boa/boa-0.94.12.ebuild,v 1.2 2002/07/14 20:25:23 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Boa - A very small and very fast http daemon."
SRC_URI="http://www.boa.org/${P}.tar.gz"
HOMEPAGE="http://www.boa.org/"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	sys-devel/flex
	sys-devel/bison
	sys-apps/texinfo
	tetex? ( app-text/tetex )"

RDEPEND="virtual/glibc"

src_compile() {
	cd src
	./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} || die
	#Note the use of --infodir and --mandir, above.  This is to make
	# this package FHS 2.2-compliant
	#(/usr/share is used for info and man now).
	
	emake || die
	cd ../docs
	make boa.html boa.info || die
	use tetex && make boa.dvi
}

src_install () {
	# make prefix=${D}/usr install
	dosbin src/boa || die
	doman docs/boa.8 || die
	dodoc docs/boa.html || die
	dodoc docs/boa_banner.png || die
	doinfo docs/boa.info || die
	if [ "`use tetex`" ]; then
		dodoc docs/boa.dvi || die
	fi
	
	dodir /var/log/boa || die
	dodir /home/httpd/htdocs || die
	dodir /home/httpd/cgi-bin || die
	dodir /home/httpd/icons || die
        
	exeinto /usr/lib/boa
	doexe src/boa_indexer || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/boa.rc6 boa || die

	insinto /etc/boa
	insopts -m700
	insopts -m600
	doins ${FILESDIR}/boa.conf || die
	doins ${FILESDIR}/mime.types || die

	# make DESTDIR=${D} install || die
}

pkg_prerm() {

	if [ "$ROOT" = "/" ] && [ -e /dev/shm/.init.d/started/boa ] ; then
		/etc/init.d/boa stop
	fi
	return # dont fail
}

pkg_preinst() {

	if [ "$ROOT" = "/" ] && [ -e /dev/shm/.init.d/started/boa ] ; then
		/etc/init.d/boa stop
	fi
	return # dont fail
}
