# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope/zope-2.6.0.ebuild,v 1.3 2003/09/08 06:02:05 msterret Exp $

S="${WORKDIR}/Zope-${PV}-src"

DESCRIPTION="Zope is a web application platform used for building high-performance, dynamic web sites."
HOMEPAGE="http://www.zope.org"
SRC_URI="http://www.zope.org/Products/Zope/${PV}/Zope-${PV}-src.tgz"
LICENSE="ZPL"
SLOT="0"

# TODO: needs to be confirmed on other platforms.
KEYWORDS="x86"

DEPEND="virtual/glibc
	dev-lang/python"

ZOPEDIR="${DESTTREE}/share/zope/${PV}/"

src_compile() {
	python w_pcgi.py || die
}

src_install() {
	ENVD_DIR=etc/env.d/
	CONFD_DIR=etc/conf.d/

	# move the main docs and compress them.
	dodoc LICENSE.txt README.txt

	docinto doc
	dodoc doc/*.txt

	docinto doc/PLATFORMS
	dodoc doc/PLATFORMS/*

	docinto doc/changenotes
	dodoc doc/changenotes/*

	#rm -fr LICENSE.txt README.txt doc/

	# patch some paths.
	sed -e "s:${S}:${ZOPEDIR}:" Zope.cgi > Zope.cgi.tmp
	mv Zope.cgi.tmp Zope.cgi
	chmod 755 Zope.cgi  # restoring permissions

	# using '/etc/init.d/zope' instead
	rm -f start stop

	# Keep others from overwritting PID files
	chmod o+t var/

	# copy the remaining contents of ${S} into the ${D}.
	dodir ${ZOPEDIR}
	cp -a . ${D}${ZOPEDIR}

	# Add a rc-script.
	insinto /etc/init.d
	newins ${FILESDIR}/${PV}/zope.initd zope

	# Add a env.d script.
	insinto /etc/env.d
	doins ${FILESDIR}/${PV}/zope.envd

	# Fill in an env.d variable.
	sed -e "/ZOPE_HOME/ c\\ZOPE_HOME=${ZOPEDIR}\\" ${D}${ENVD_DIR}zope.envd \
	> ${D}${ENVD_DIR}zope.tmp
	mv ${D}${ENVD_DIR}zope.tmp ${D}${ENVD_DIR}50zope

	# Add a conf.d script.
	dodir ${CONFD_DIR}
	echo -e "ZOPE_OPTS='-u root'\nZOPE_HOME=${ZOPEDIR}" > ${D}${CONFD_DIR}zope
}

pkg_postinst() {
	einfo "To get zope running you must execure the following:"
	einfo "\tebuild /var/db/pkg/net-www/${PF}/${P}.ebuild config"
}

pkg_config() {
	einfo ">>> Create inital user...${ROOT}\n"
	python ${ROOT}${ZOPEDIR}zpasswd.py ${ROOT}${ZOPEDIR}inituser
}

