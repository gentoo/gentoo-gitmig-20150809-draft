# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/opendict/opendict-0.5.4.ebuild,v 1.4 2004/08/30 23:24:31 dholm Exp $

inherit python

DESCRIPTION="OpenDict is a free cross-platform dictionary program."
HOMEPAGE="http://opendict.sourceforge.net/"
SRC_URI="mirror://sourceforge/opendict/OpenDict-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=dev-python/wxpython-2.4.2.4
	virtual/python"
S=${WORKDIR}/OpenDict-${PV}

src_unpack() {
	python_version
	unpack ${A}
	cd ${S}
	DHOME="/usr/lib/python${PYVER}/site-packages/opendict"
	sed -i "s:/usr/share/opendict:${DHOME}:" lib/info.py || die "sed failed"
	rm Makefile
}

src_install() {
	python_version
	DHOME="${D}/usr/lib/python${PYVER}/site-packages/opendict"
	dodir /usr/share/locale/lt/LC_MESSAGES
	dodir /usr/share/applications
	dodir /usr/share/opendict
	mkdir -p ${DHOME}
	cp -r lib/* ${DHOME}
	cp -r pixmaps/ ${DHOME}
	cp po/lt/opendict.mo ${D}/usr/share/locale/lt/LC_MESSAGES/
	cp opendict.py ${DHOME}
	cp copying.txt ${DHOME}
	dodir /usr/bin
	fperms 755 /usr/lib/python${PYVER}/site-packages/opendict/opendict.py
	dosym /usr/lib/python${PYVER}/site-packages/opendict/opendict.py /usr/bin/opendict || die "dosym failed"

	cp misc/opendict.desktop ${D}/usr/share/applications/
	dodoc BUGS ChangeLog README.txt TODO.txt doc/OpenDict_plugin_dev.txt
}

pkg_postinst() {
	einfo "You can download plugins from:"
	einfo "http://kebil.ghost.lt/OpenDict_plugins.html"
	einfo "Put them in /usr/share/${PN} for system-wide use or"
	einfo "~/.opendict/plugins/"
}

