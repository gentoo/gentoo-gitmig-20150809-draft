# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pykde/pykde-3.11.3.ebuild,v 1.4 2004/11/25 12:55:43 carlo Exp $

inherit eutils distutils

MY_P=PyKDE-${PV/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="set of Python bindings for the KDE libs"
#SRC_URI="http://www.river-bank.demon.co.uk/download/PyKDE2/${MY_P}.tar.gz"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/pykde/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE="debug doc kjs"

DEPEND="virtual/libc
	sys-devel/libtool
	virtual/python
	>=dev-python/sip-3.10.2
	>=dev-python/PyQt-3.12
	kde-base/kdelibs
	!>=kde-base/kdelibs-3.3.1"

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
