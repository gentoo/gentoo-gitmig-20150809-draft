# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jon Nelson <jnelson@boa.org>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

#Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}
S=${WORKDIR}/${P}

#Short one-line description
DESCRIPTION="Boa - A very small and very fast http daemon."

#Point to any required sources; these will be automatically downloaded
# by Portage
SRC_URI="http://www.boa.org/${P}.tar.gz"

#Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://www.boa.org/"

#build-time dependencies
DEPEND="virtual/glibc
	sys-devel/flex
	sys-devel/bison
	sys-apps/texinfo
        tex? ( app-text/tetex )"

#run-time dependencies, same as DEPEND if RDEPEND isn't defined:
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
	echo "`use tex`"
	if [ ! -z "`use tex`" ]; then
		make boa.dvi || die
	fi
}

src_install () {
	# make prefix=${D}/usr install
	dosbin src/boa || die
	doman docs/boa.8 || die
	dodoc docs/boa.html || die
	dodoc docs/boa_banner.png || die
	doinfo docs/boa.info || die
	if [ ! -z "`use tex`" ]; then
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
