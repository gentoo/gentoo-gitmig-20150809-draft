# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted/twisted-1.0.4.ebuild,v 1.2 2003/05/11 13:11:26 lordvan Exp $

IUSE="gtk2 doc"

S=${WORKDIR}/Twisted-${PV}
DESCRIPTION="Twisted is a collection of servers and clients, which can be used either by developers of new applications or directly. Documentation included." 
SRC_URI="http://twisted.sourceforge.net/Twisted-${PV}.tar.bz2"
HOMEPAGE="http://www.twistedmatrix.com/"
LICENSE="LGPL-2.1"
SLOT="0"
DEPEND="virtual/python
	>=dev-python/pycrypto-1.9_alpha4
	gtk? ( =dev-python/pygtk-0.6* ) 
	gtk2? ( >=dev-python/pygtk-1.99 )"
KEYWORDS="~x86 ~alpha ~sparc "

inherit distutils

src_install() {
	distutils_src_install
		
	# of course it's documentation!
	doman doc/man/*.[0-9n]
	rm -rf doc/man	# don't dupe the man pages
	
	# next few lines will install docs: 9.4 megs!
	if [ -n "`use doc`" ]; then
		cd ${S}/doc
		dodir /usr/share/doc/${PF}
		cp -r . ${D}/usr/share/doc/${PF}
	fi
	
	# use gtk2 if they so wish
	if [ -n "`use gtk2`" ]; then
		sed -e 's/import manhole/import manhole2/' \
			-e 's/manhole\.run()/manhole2.run()/' \
			-i ${D}/usr/bin/manhole
	fi

}

