# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted/twisted-1.0.6.ebuild,v 1.4 2003/09/06 23:32:29 msterret Exp $

inherit distutils

DESCRIPTION="collection of servers and clients, which can be used either by developers of new applications or directly. Documentation included."
HOMEPAGE="http://www.twistedmatrix.com/"
SRC_URI="http://twisted.sourceforge.net/Twisted-${PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 alpha sparc"
IUSE="gtk2 doc"

DEPEND=">=dev-lang/python-2.2*
	>=dev-python/pycrypto-1.9_alpha4
	gtk? ( =dev-python/pygtk-0.6* )
	gtk2? ( >=dev-python/pygtk-1.99* )"

S=${WORKDIR}/Twisted-${PV}

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
