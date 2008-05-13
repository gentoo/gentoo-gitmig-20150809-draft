# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt/PyQt-3.17.ebuild,v 1.10 2008/05/13 08:52:27 hawking Exp $

inherit distutils

MY_P="PyQt-x11-gpl-${PV/*_pre/snapshot-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="PyQt is a set of Python bindings for the Qt toolkit."
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/pyqt/intro/"
#SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
SRC_URI="http://www.riverbankcomputing.com/Downloads/PyQt3/GPL/${MY_P}.tar.gz"
#SRC_URI="http://www.riverbankcomputing.com/Downloads/Snapshots/PyQt3/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE="debug doc examples"

RDEPEND="=x11-libs/qt-3*
	>=dev-python/sip-4.4.1
	x11-libs/qscintilla"
DEPEND="${RDEPEND}
	sys-devel/libtool"

src_unpack() {
	unpack ${A}
	sed -i -e "s:  check_license():# check_license():" "${S}"/configure.py
}

src_compile() {
	distutils_python_version
	addpredict ${QTDIR}/etc/settings

	local myconf="-d /usr/$(get_libdir)/python${PYVER}/site-packages \
			-b /usr/bin \
			-v /usr/share/sip \
			-n /usr/include \
			-o /usr/$(get_libdir) \
			-w -y qt-mt"
	use debug && myconf="${myconf} -u"

	python configure.py ${myconf}
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc ChangeLog LICENSE NEWS README README.Linux THANKS
	use doc && dohtml doc/PyQt.html
	if use examples ; then
		dodir /usr/share/doc/${PF}/examples
		cp -r examples3/* "${D}"/usr/share/doc/${PF}/examples
	fi
}
