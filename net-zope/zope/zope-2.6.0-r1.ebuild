# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope/zope-2.6.0-r1.ebuild,v 1.3 2003/06/09 22:05:10 msterret Exp $

S="${WORKDIR}/Zope-${PV}-src"

DESCRIPTION="Zope is a web application platform used for building high-performance, dynamic web sites."
HOMEPAGE="http://www.zope.org"
SRC_URI="http://www.zope.org/Products/Zope/${PV}/Zope-${PV}-src.tgz"
LICENSE="ZPL"
SLOT="0"

KEYWORDS="x86"

DEPEND="virtual/glibc
	>=sys-apps/sed-4
	=dev-lang/python-2.1.3*"

ZOPEDIR="${DESTTREE}/share/zope/${PV}/"

src_compile() {
	python2.1 wo_pcgi.py || die "Failed to compile."
}

src_install() {

  	dodoc LICENSE.txt README.txt
	docinto doc ; dodoc doc/*.txt
	docinto doc/PLATFORMS ; dodoc doc/PLATFORMS/*
	docinto doc/changenotes ; dodoc doc/changenotes/*

	# using '/etc/init.d/zope'
	rm -Rf start stop LICENCE.txt doc/

	# copy the remaining contents of ${S} into the ${D}.
	dodir ${ZOPEDIR}
	cp -a . ${D}${ZOPEDIR}

	# Add a rc-script.
	exeinto /etc/init.d ; newexe ${FILESDIR}/${PV}/zope.initd zope

	# Add a env.d script.
	insinto /etc/env.d ; doins ${FILESDIR}/${PV}/zope.envd

	# Fill in an env.d variable.
	sed -i \
		-e "/ZOPE_HOME/ c\\ZOPE_HOME=${ZOPEDIR}\\" ${D}/etc/env.d/zope.envd || \
		die "sed zope.envd failed"

	# Add a conf.d script.
	dodir /etc/conf.d
	echo -e "ZOPE_OPTS='-u root'\nZOPE_HOME=${ZOPEDIR}" > ${D}/etc/conf.d/zope

	# Keep others from overwritting PID files
	fperms o+t ${ZOPEDIR}var/

	# Useful link
	dosym /usr/share/doc/${P}/doc/ ${ZOPEDIR}doc
}

pkg_postinst() {
	einfo "To get zope running you must execute the following:"
	einfo "\tebuild /var/db/pkg/net-zope/${PF}/${PF}.ebuild config"
}

pkg_config() {
	einfo ">>> Create initial user..."
	python2.1 ${ROOT}${ZOPEDIR}zpasswd.py ${ROOT}${ZOPEDIR}inituser
}
