# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope/zope-2.4.0-r6.ebuild,v 1.7 2004/01/21 21:21:49 lanius Exp $

S=${WORKDIR}/Zope-${PV}-src
DESCRIPTION="Zope is web application platform used for building high-performance, dynamic web sites."
SRC_URI="http://www.zope.org/Products/Zope/${PV}/Zope-${PV}-src.tgz
	http://www.zope.org/Products/ZEO/ZEO-1.0b3.tgz"
HOMEPAGE="http://www.zope.org"

DEPEND="virtual/glibc
	=dev-lang/python-2.1*"
RDEPEND="=dev-lang/python-2.1*"
KEYWORDS="x86 sparc "
SLOT="${PV}"
LICENSE="as-is"

src_unpack() {

	unpack Zope-${PV}-src.tgz

	if [ "`use zeo`" ]; then
		cd ${S}/lib/python
		unpack ZEO-1.0b3.tgz
		mv ZEO-1.0b3/ZEO ${S}/lib/python
		rm -rf ZEO-1.0b3
	fi
}

src_compile() {
	python2.1 w_pcgi.py || die
}

src_install () {

	ZDIR=/usr/share/zope
	ZVAR=/var/lib/zope


	dodir ${ZDIR}/var
	insinto ${ZDIR}
	doins w_pcgi.py wo_pcgi.py

	dodir ${ZDIR}/lib
	cp -a lib/* ${D}${ZDIR}/lib/
	cp -a ZServer utilities ${D}${ZDIR}
	rm ${D}${ZDIR}/ZServer/*.txt
	exeinto ${ZDIR}/pcgi
	doexe pcgi/pcgi-wrapper pcgi/pcgi_publisher.py

	dodir ${ZDIR}/inst
	cp -a inst/* ${D}${ZDIR}/inst

	dodir ${ZDIR}/pcgi
	cp -a pcgi/* ${D}${ZDIR}/pcgi

	cd ${S}
	fperms a+x ${ZDIR}/lib/python/zdaemon.py
	fperms a+x	${ZDIR}/lib/python/StructuredText/StructuredText.py
	fperms a+x	${ZDIR}/lib/python/ZPublisher/Client.py

	dodir ${ZVAR}
	insinto ${ZVAR}
	doins z2.py
	insinto ${ZVAR}/var
	insopts -m644
	doins var/Data.fs.in
	dodir ${ZVAR}/Extensions
	dodir ${ZVAR}/import
	dodir ${ZVAR}/Products

	if [ "`use zeo`" ]; then
		insinto ${ZVAR}
		doins ${FILESDIR}/zctl.py  ${FILESDIR}/zope  ${FILESDIR}/zope.conf ${FILESDIR}/custom_zodb.py
	fi

	exeinto ${ZDIR}
	doexe zpasswd.py Zope.cgi

	cd ${D}${ZDIR}
	sed -e "s:${WORKDIR}:${ZDIR}:g" Zope.cgi > Zope.cgi.tmp
	mv Zope.cgi.tmp Zope.cgi
	sed -e "s:${WORKDIR}:${ZVAR}:g" stop > stop.tmp
	mv stop.tmp stop

	dodir /etc/init.d
	exeinto /etc/init.d
	newexe ${FILESDIR}/zope.rc6 zope
	chown nobody:users ${ZVAR}/var/*
}

pkg_postinst() {
	if [ ! -f ${ROOT}/var/lib/zope/var/Data.fs ]
	then
		echo "Installing Data.fs from template..."
		cd ${ROOT}/var/lib/zope/var
		cp Data.fs.in Data.fs
		echo
		echo "Fixing permissions..."
		chown nobody:nogroup -R ${ROOT}/var/lib/zope/var
		chmod 600 ${ROOT}/var/lib/zope/var/Data.fs
		echo
	fi
	if [ ! -f ${ROOT}/var/lib/zope/access ]
	then
		echo "You must run"
		echo
		echo /usr/share/zope/zpasswd.py /var/lib/zope/inituser
		if [ "`use zeo`" ]; then
			echo and edit /var/lib/zope/zope.conf
		fi

		echo
		echo before you can start zope
	fi
}
