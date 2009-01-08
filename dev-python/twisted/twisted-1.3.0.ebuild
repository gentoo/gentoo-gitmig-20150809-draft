# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted/twisted-1.3.0.ebuild,v 1.14 2009/01/08 23:25:18 patrick Exp $

inherit distutils

# for alphas,..
MY_PV="${PV/_alpha/alpha}"
DESCRIPTION="An asynchronous networking framework written in Python"
HOMEPAGE="http://www.twistedmatrix.com/"
SRC_URI="http://twisted.sourceforge.net/Twisted_NoDocs-${MY_PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ~ppc ~sparc ~x86"
IUSE="gtk doc"

DEPEND=">=dev-lang/python-2.2
	>=dev-python/pycrypto-1.9_alpha6
	dev-python/pyserial
	dev-python/pyopenssl
	gtk? ( >=dev-python/pygtk-1.99 )
	doc? ( =dev-python/twisted-docs-${PV} )"

S=${WORKDIR}/Twisted-${MY_PV}

src_install() {
	distutils_src_install

	# use gtk2 if they so wish
	if use gtk; then
		sed -e 's/import manhole/import manhole2/' \
			-e 's/manhole\.run()/manhole2.run()/' \
			-i '${D}/usr/bin/manhole'
	fi
}
