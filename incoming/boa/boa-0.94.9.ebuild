# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jon Nelson <jnelson@boa.org>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

#Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}
S=${WORKDIR}/${P}

#Short one-line description
DESCRIPTION="Boa - 1 line"

#Point to any required sources; these will be automatically downloaded
# by Portage
SRC_URI="http://www.boa.org/${P}.tar.gz"

#Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://www.boa.org/"

#build-time dependencies
DEPEND="virtual/glibc
	sys-devel/flex
	sys-devel/bison
	sys-apps/texinfo"

#run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

src_compile() {
    cd src
    #the "try" command will stop the build process if the specified
    #command fails.  Prefix critical
    #commands with "try"
    try ./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} || die
    #Note the use of --infodir and --mandir, above.  This is to make
    # this package FHS 2.2-compliant
    #(/usr/share is used for info and man now).
    local myconf
	
	try emake
	cd ../docs
	try emake boa.html boa.info
#	if [ -z "`use latex`" ]; then
#	  try emake boa.dvi
#	fi
	#emake (previously known as pmake) is a script that calls the standard
	# GNU make with parallel
	#building options for speedier builds on SMP systems.  Use emake first;
	# it might not work.  If not, then replace the line above with:

	#make || die
}

src_install () {
	#you must *personally verify* that this trick doesn't install
	#anything outside of DESTDIR; do this by reading and understanding
	#the install part of the Makefiles.  Also note that this will often
	#also work for autoconf stuff (usually much more often than DESTDIR,
	#which is actually quite rare.
	
	# make prefix=${D}/usr install
	try dosbin src/boa
	try doman docs/boa.8
	try dodoc docs/boa.html
	try doinfo docs/boa.info
	
	try dodir /var/log/boa
	try dodir /home/httpd/html
	try dodir /home/httpd/cgi-bin
	
	exeinto /usr/lib/boa
	try doexe src/boa_indexer

	exeinto /etc/init.d
	try newexe ${FILESDIR}/boa.rc6 boa

	insinto /etc/boa
	insopts -m700
	insopts -m600
	try doins ${FILESDIR}/boa.conf
	try doins ${FILESDIR}/mime.types

	# make DESTDIR=${D} install || die
	#again, verify the Makefiles!  We don't want anything falling outside
	#of ${D}.
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
