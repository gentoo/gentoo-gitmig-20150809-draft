# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/straw/straw-0.21.2.ebuild,v 1.1 2005/03/18 14:22:06 seemant Exp $

inherit gnome2 python distutils eutils

DESCRIPTION="RSS/RDF News Aggregator"
HOMEPAGE="http://www.nongnu.org/straw/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${PN}.pkg/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
RDEPEND=">=dev-lang/python-2.2.3-r3
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2.0.1
	>=dev-python/gnome-python-1.99.13
	>=dev-python/pygtk-1.99.13-r1
	>=dev-python/bsddb3-3.4.0
	>=dev-python/egenix-mx-base-2
	>=dev-python/adns-python-1.0.0"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

MAKEOPTS="${MAKEOPTS} -j1"

# boo-boo by upstream devs, remove in next version
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	python_version
	sed -e "s:-d \$(BINDIR) \$(LIBDIR) \$(DATADIR):-d \$(BINDIR) \$(LIBDIR) \$(DATADIR) \$(APPLICATIONSDIR) \$(ICONDIR):" \
		-e "s:^\(PYTHON.*\)python2.2:\1python${PYVER}:" \
		-e "s:^\(LIBDIR.*\)python2.2\(.*\):\1python${PYVER}\2:" \
		-e "s:py\[co\]:py:" \
		-i ${S}/Makefile || die "sed failed"
	sed -e "s:/usr/bin/env python2.2:/usr/bin/env python${PYVER}:" \
		-i ${S}/src/straw
	# probably can remove in next version - fixes f.truncate() errors.
	# http://savannah.nongnu.org/bugs/?func=detailitem&item_id=6816
	EPATCH_OPTS="-d ${S}/src/lib" epatch ${FILESDIR}/${P}-convert_config.patch
}

src_compile() {
	export LC_ALL="C"
	# disable gconftool from violating sandbox, reported upstream.
	# remove in next version.
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	emake || die "make failed"
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make PREFIX=${D}/usr \
		SYSCONFDIR=${D}/etc \
		SCHEMADIR=${D}/etc/gconf/schemas \
		install || die "install failed"
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
	dodoc NEWS README TODO
}

pkg_postinst() {
	distutils_pkg_postinst
	gnome2_pkg_postinst # need this for gconf schemas
}

pkg_postrm() {
	distutils_pkg_postrm
	gnome2_pkg_postrm
}
