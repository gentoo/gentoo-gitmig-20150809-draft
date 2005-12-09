# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pykde/pykde-3.12_pre20051013.ebuild,v 1.1 2005/12/09 22:16:45 carlo Exp $

inherit eutils distutils

MY_P="PyKDE-${PV/*_pre/snapshot}"
MY_P=${MY_P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="PyKDE is a set of Python bindings for kdelibs."
HOMEPAGE="http://www.riverbankcomputing.co.uk/pykde/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
#SRC_URI="http://www.river-bank.demon.co.uk/download/PyKDE2/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="debug doc examples"

RDEPEND=">=dev-python/sip-3.10.2
	>=dev-python/PyQt-3.12
	kde-base/kdelibs
	!kde-base/pykde"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/pykde-3.12_pre20051013-kde35.diff"
}
src_compile() {
	distutils_python_version

	local myconf="-d ${ROOT}/usr/$(get_libdir)/python${PYVER}/site-packages \
			-v ${ROOT}/usr/share/sip \
			-k $(kde-config --prefix)"

	use debug && myconf="${myconf} -u"

	python configure.py ${myconf}
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	find ${D}/usr/share/sip -not -type d -not -iname *.sip -exec rm '{}' \;

	dodoc AUTHORS ChangeLog NEWS README THANKS
	use doc && dohtml -r doc/*
	if use examples ; then
		cp -r examples ${D}/usr/share/doc/${PF}
		cp -r templates ${D}/usr/share/doc/${PF}
	fi
}
