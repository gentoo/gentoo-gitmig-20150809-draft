# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pykde/pykde-3.11_rc1.ebuild,v 1.2 2004/06/08 20:30:44 dholm Exp $

inherit eutils distutils

MY_P=PyKDE-${PV/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="set of Python bindings for the KDE libs"
SRC_URI="http://www.river-bank.demon.co.uk/download/PyKDE2/${MY_P}.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/pykde/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="debug doc kjs"

DEPEND="virtual/glibc
	sys-devel/libtool
	virtual/python
	>=dev-python/sip-3.10.1
	>=dev-python/PyQt-3.11
	<kde-base/kdelibs-3.2.3"

src_compile() {
	cd ${S}
	distutils_python_version

	local myconf="-d /usr/lib/python${PYVER}/site-packages \
			-v /usr/share/sip \
			-c"
	use debug && myconf="${myconf} -r -u"
	use kjs && myconf="${myconf} -m"

	python configure.py ${myconf}
	emake || die
}

src_install() {
	einstall DESTDIR=${D} || die
	find ${D}/usr/share/sip -not -type d -not -iname *.sip -exec rm '{}' \;
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README THANKS
	use doc && ( cp -r examples ${D}/usr/share/doc/${PF}
			cp -r templates ${D}/usr/share/doc/${PF}
			dohtml -r doc/* )
}
