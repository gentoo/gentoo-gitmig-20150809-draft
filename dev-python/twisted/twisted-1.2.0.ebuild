# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted/twisted-1.2.0.ebuild,v 1.10 2004/10/17 12:01:51 absinthe Exp $

inherit distutils

DESCRIPTION="collection of servers and clients, which can be used either by developers of new applications or directly. Documentation included."
HOMEPAGE="http://www.twistedmatrix.com/"
SRC_URI="http://twisted.sourceforge.net/Twisted_NoDocs-${PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc alpha"
IUSE="gtk gtk2 doc"

DEPEND=">=dev-lang/python-2.2
	>=dev-python/pycrypto-1.9_alpha6
	dev-python/pyserial
	dev-python/pyopenssl
	gtk? ( gtk2? ( >=dev-python/pygtk-1.99* ) !gtk2? ( =dev-python/pygtk-0.6* ) )
	doc? ( =dev-python/twisted-docs-${PV} )"

S=${WORKDIR}/Twisted-${PV}

src_install() {
	distutils_src_install

	# use gtk2 if they so wish
	if use gtk2; then
		sed -e 's/import manhole/import manhole2/' \
			-e 's/manhole\.run()/manhole2.run()/' \
			-i ${D}/usr/bin/manhole
	fi
}
