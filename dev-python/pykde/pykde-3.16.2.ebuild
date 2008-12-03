# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pykde/pykde-3.16.2.ebuild,v 1.1 2008/12/03 07:39:28 patrick Exp $

inherit kde eutils distutils 

MY_P="PyKDE-${PV/*_pre/snapshot}"
MY_P=${MY_P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="PyKDE is a set of Python bindings for kdelibs."
HOMEPAGE="http://www.riverbankcomputing.co.uk/pykde/"
#SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
SRC_URI="http://www.riverbankcomputing.com/Downloads/PyKDE3/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug doc examples"

#Wow, this can't work - kdebase will block kdelibs
#DEPEND="|| ( =kde-base/kdebase-3.5* =kde-base/konsole-3.5* )"
RDEPEND=">=dev-python/sip-4.7
	>=dev-python/PyQt-3.17.3
	=kde-base/kdelibs-3.5*
	!kde-base/pykde"
DEPEND="${RDEPEND} =kde-base/konsole-3.5*"

#src_unpack() {
#	unpack ${A}
#	epatch "${FILESDIR}"/PyKDE-3.16.0-sip-4.7.patch
#}

src_compile() {
	distutils_python_version
	echo $PATH
	local myconf="-d /usr/$(get_libdir)/python${PYVER}/site-packages \
			-v /usr/share/sip \
			-k $(kde-config --prefix)
			-L $(get_libdir)"

	use debug && myconf="${myconf} -u"
	myconf="${myconf} -i"

	"${python}" configure.py ${myconf}
	emake || die "emake install failed"
}

src_install() {
	dodir /usr/kde/3.5/lib/
	sed -i -e 's:/usr/kde/3.5/lib/libkonsolepart.so:$(DESTDIR)/usr/kde/3.5/lib/libkonsolepart.so:' Makefile
	emake DESTDIR="${D}" install || die "emake install failed"
#	find ${D}/usr/share/sip -not -type d -not -iname *.sip -exec rm '{}' \;

	dodoc AUTHORS ChangeLog NEWS README THANKS
	use doc && dohtml -r doc/*
	if use examples ; then
		insinto "/usr/share/doc/${PF}"
		doins -r examples
		doins -r templates
	fi
}
