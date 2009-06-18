# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/clinkcc/clinkcc-1.7.1.ebuild,v 1.1 2009/06/18 18:57:17 volkmar Exp $

EAPI="2"

inherit autotools eutils versionator

MY_PV=$(delete_all_version_separators)
MY_P=${PN}${MY_PV}
DOC_PV=170

DESCRIPTION="CyberLink for C++ is a development package for UPnP"
HOMEPAGE="http://sourceforge.net/projects/clinkcc/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	doc? ( mirror://sourceforge/${PN}/${PN}doxygen${DOC_PV}.zip
		mirror://sourceforge/${PN}/${PN}proguide${DOC_PV}.pdf )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc examples expat mythtv xml"

RDEPEND="expat? ( >=dev-libs/expat-1.95 )
	mythtv? ( virtual/mysql )
	xml? ( >=dev-libs/libxml2-2.6.20 )
	!expat? ( !xml? ( >=dev-libs/xerces-c-2.3.0 ) )
	virtual/libiconv"
DEPEND="${RDEPEND}
	doc? ( app-arch/unzip )"

S=${WORKDIR}/CyberLink

src_prepare() {
	# do not build examples (fix in .am as we _have_ to do an autoreconf)
	sed -i -e "s:sample::" Makefile.am || die "sed failed"

	epatch "${FILESDIR}"/${P}-gentoo.patch

	eautoreconf # fix install-sh permission denied
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable expat) \
		$(use_enable mythtv) \
		$(use_enable xml libxml2)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r sample/* || die "doins failed"
		ewarn "Installed examples Makefiles will probably not work."
		ewarn "If you want easy-to-compile examples, you should use ${PN} tarball."
	fi

	if use doc; then
		dohtml -r "${WORKDIR}"/clinkccdoxygen/html/* || die "dohtml failed"
		dodoc "${DISTDIR}"/${PN}proguide${DOC_PV}.pdf || die "dodoc failed"
	fi
}
