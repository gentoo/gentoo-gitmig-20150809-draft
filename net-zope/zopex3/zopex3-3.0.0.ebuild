# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zopex3/zopex3-3.0.0.ebuild,v 1.1 2004/11/08 09:31:28 radek Exp $

inherit eutils

MYPN="ZopeX3"

DESCRIPTION="Zope is a web application platform used for building high-performance, dynamic web sites."
HOMEPAGE="http://www.zope.org"
SRC_URI="http://www.zope.org/Products/${MYPN}/${PV}final/${MYPN}-${PV}.tgz"
LICENSE="ZPL"
SLOT="${PV}"
IUSE=""

KEYWORDS="~x86 ~ppc"

RDEPEND="=dev-lang/python-2.3*"
python='python2.3'

DEPEND="${RDEPEND}
virtual/libc
>=sys-apps/sed-4.0.5"

S="${WORKDIR}/${MYPN}-${PV}"
ZS_DIR=${ROOT%/}/usr/lib
ZSERVDIR=${ZS_DIR}/${PN}-${PV}
ZSKELDIR=${ZSERVDIR}/zopeskel
ZINSTDIR=/var/lib/zope/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	./configure --prefix=${D}${ZSERVDIR} || die "Failed to configure."
	emake || die "Failed to compile."
}

src_install() {

	dodoc README.txt
	dodoc ZopeX3/doc/*.txt
	docinto schema
	dodoc ZopeX3/doc/schema/*
	docinto security
	dodoc ZopeX3/doc/security/*
	docinto skins
	dodoc ZopeX3/doc/skins/*
	docinto style
	dodoc ZopeX3/doc/style/*
	docinto zcml
	dodoc ZopeX3/doc/zcml/*

	make install prefix=${D}${ZSERVDIR}

	dosym ../../share/doc/${PF} ${ZSERVDIR}/doc

	# copy the init script skeleton to zopeskel directory of our installation
	cp ${FILESDIR}/zope.initd ${D}${ZSKELDIR}/zope.initd
}

pkg_postinst() {

	einfo "This release ($PN) can create default instance. Please use command shown below:"
	einfo "  ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
}

pkg_prerm() {

	find ${ZSERVDIR}/lib/python -name \*.py[co] -exec rm -f {} \;
}

pkg_postrm() {

	rmdir /usr/lib/${ZSERVDIR} 2>/dev/null
}

pkg_config() {

	if [ -f /etc/init.d/${PN} -o -d ${ZINSTDIR} ]
	then
		ewarn "Default instance already exists, aborting.."
		ewarn "Please delete first /etc/init.d/${PN} and ${ZINSTDIR}"
		die "Failed to create default instance."
	fi

	${ZSERVDIR}/bin/mkzopeinstance -d ${ZINSTDIR} -u admin:admin
	mkdir -p ${ZINSTDIR}

	# remove unnecessary zope.initd
	rm -f ${ZINSTDIR}/zope.initd

	# log symlink
	rm -rf ${ZINSTDIR}/log
	mkdir -p /var/log/zope/${PN}
	ln -s /var/log/zope/${PN} ${ZINSTDIR}/log

	# draconian permissions :)
	chmod go-rwx -R ${ZINSTDIR}

	cp ${ZSKELDIR}/zope.initd /etc/init.d/${PN}
	chmod 755 /etc/init.d/${PN}
	sed -i -e "s|INSTANCE_HOME|${ZINSTDIR}|" /etc/init.d/${PN}

	einfo "Default instance created at ${ZINSTDIR}"
	einfo "Created default user 'admin' with password 'admin'."
	einfo "Be warned that this instance is prepared to run as root only."
	einfo "To start instance (ports 8080,8021,) use: /etc/init.d/${PN} start"
}
