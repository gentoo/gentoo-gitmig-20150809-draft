# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/system-config-printer-common/system-config-printer-common-1.1.18-r1.ebuild,v 1.1 2010/03/27 15:44:48 reavertm Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python autotools

MY_P="${PN%-common}-${PV}"

DESCRIPTION="Common modules of Red Hat's printer administration tool"
HOMEPAGE="http://cyberelk.net/tim/software/system-config-printer/"
SRC_URI="http://cyberelk.net/tim/data/system-config-printer/1.1/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
IUSE="doc policykit"

# system-config-printer split since 1.1.3
COMMON_DEPEND="
	dev-libs/libxml2[python]
	dev-python/dbus-python
	dev-python/pycups
	dev-python/pygobject
	net-print/cups[dbus]
"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	doc? ( dev-python/epydoc )
"
RDEPEND="${COMMON_DEPEND}
	!app-admin/system-config-printer:0
	policykit? ( sys-auth/polkit )
"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}/${P}-split.patch"

	eautoreconf
}

src_configure() {
	econf \
		--disable-nls \
		--with-polkit-1
}

src_compile() {
	emake || die "emake failed"
	if 	use doc; then
		emake html || die "emake html failed"
	fi
}

src_install() {
	dodoc AUTHORS ChangeLog README || die "dodoc failed"

	if use doc; then
		dohtml -r html/ || die "installing html docs failed"
	fi

	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	python_mod_optimize cupshelpers /usr/share/system-config-printer
}

pkg_postrm() {
	python_mod_cleanup cupshelpers /usr/share/system-config-printer
}
