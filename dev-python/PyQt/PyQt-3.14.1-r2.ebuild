# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt/PyQt-3.14.1-r2.ebuild,v 1.1 2006/10/22 15:12:11 carlo Exp $

inherit distutils eutils

MY_P="PyQt-x11-gpl-${PV/*_pre/snapshot-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="set of Python bindings for the QT 3.x Toolkit"
HOMEPAGE="http://www.riverbankcomputing.co.uk/pyqt/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug doc examples"

RDEPEND="x11-libs/qt
	~dev-python/sip-4.2.1
	dev-python/qscintilla"
DEPEND="${RDEPEND}
	sys-devel/libtool"


src_unpack() {
	unpack ${A}
	sed -i -e "s:  check_license():# check_license():" ${S}/configure.py
	cd ${S}
	epatch "${FILESDIR}/PyQt-3.14.1-examples.diff"
	epatch "${FILESDIR}/PyQt-3.14.1-python-2.5-compat.diff"
}

src_compile() {
	distutils_python_version
	addpredict ${QTDIR}/etc/settings

	local myconf="-d ${ROOT}/usr/$(get_libdir)/python${PYVER}/site-packages \
			-b ${ROOT}/usr/bin \
			-v ${ROOT}/usr/share/sip \
			-n ${ROOT}/usr/include \
			-o ${ROOT}/usr/$(get_libdir)"
	use debug && myconf="${myconf} -u"

	python configure.py ${myconf}
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc ChangeLog LICENSE NEWS README README.Linux THANKS
	use doc && dohtml doc/PyQt.html
	if use examples ; then
		dodir /usr/share/doc/${PF}/examples
		cp -r examples3/* ${D}/usr/share/doc/${PF}/examples
	fi
}
