# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt/PyQt-3.14.ebuild,v 1.2 2005/03/29 20:06:44 kloeri Exp $

inherit distutils

MY_P="PyQt-x11-gpl-${PV/*_pre/snapshot-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="set of Python bindings for the QT 3.x Toolkit"
HOMEPAGE="http://www.riverbankcomputing.co.uk/pyqt/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
#SRC_URI="http://www.river-bank.demon.co.uk/download/PyQt/${MY_P}.tar.gz"
#SRC_URI="http://www.river-bank.demon.co.uk/download/snapshots/PyQt/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ppc64"
IUSE="debug doc"

RDEPEND="virtual/libc
	x11-libs/qt
	dev-lang/python
	>=dev-python/sip-4.2
	<dev-python/qscintilla-1.6"
DEPEND="${RDEPEND}
	sys-devel/libtool"


src_unpack() {
	unpack ${A}
	sed -i -e "s:  check_license():# check_license():" ${S}/configure.py
}

src_compile() {
	distutils_python_version
	addpredict ${QTDIR}/etc/settings

	local myconf="-d /usr/$(get_libdir)/python${PYVER}/site-packages -b /usr/bin \
			-v /usr/share/sip -n /usr/include -o /usr/$(get_libdir)"
	use debug && myconf="${myconf} -u"
	has distcc ${FEATURES} || myconf="${myconf} -c"

	if [ "$(echo $(free -m | grep Mem) | cut -d' ' -f2)" -lt "257" ] ; then
		echo ""
		einfo "Low on memory?! Use distcc or get a coffee. :)"
		echo ""
	fi

	python configure.py ${myconf}
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc ChangeLog LICENSE NEWS README README.Linux THANKS
	if use doc ; then
		dohtml doc/PyQt.html
		dodir /usr/share/doc/${PF}/examples
		cp -r examples3/* ${D}/usr/share/doc/${PF}/examples
	fi
}
