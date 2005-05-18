# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/opendict/opendict-0.5.7.ebuild,v 1.2 2005/05/18 14:11:21 swegener Exp $

inherit eutils python

DESCRIPTION="OpenDict is a free cross-platform dictionary program."
HOMEPAGE="http://opendict.sourceforge.net/"
SRC_URI="mirror://sourceforge/opendict/OpenDict-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=dev-python/wxpython-2.6
	sys-devel/gettext"
S=${WORKDIR}/OpenDict-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	rm Makefile
	epatch ${FILESDIR}/${P}-gentoo-wxversion.patch
}

src_install() {
	python_version
	DHOME="${D}/usr/lib/python${PYVER}/site-packages/opendict"
	dodir /usr/share/locale/lt/LC_MESSAGES
	dodir /usr/share/applications
	dodir /usr/share/opendict
	mkdir -p ${DHOME}/lib
	cp -r lib/* ${DHOME}/lib/ || die "Couldn't cp lib/"
	cp -r pixmaps/ ${DHOME} || die "Couldn't cp pixmaps/"
	cp opendict.py ${DHOME}
	dodir /usr/bin
	fperms 755 /usr/lib/python${PYVER}/site-packages/opendict/opendict.py
	dosym /usr/lib/python${PYVER}/site-packages/opendict/opendict.py \
		/usr/bin/opendict || die "dosym failed"

	cp misc/opendict.desktop ${D}/usr/share/applications/
	dodoc README.txt TODO.txt doc/OpenDict_plugin_dev.txt
}

pkg_postinst() {
	einfo "You can download plugins from:"
	einfo "http://kebil.ghost.lt/OpenDict_plugins.html"
	einfo "Put them in /usr/share/${PN} for system-wide use or"
	einfo "~/.opendict/plugins/"
}
