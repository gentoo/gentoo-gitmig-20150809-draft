# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope/zope-3.1.0.ebuild,v 1.2 2005/12/27 18:06:19 radek Exp $

inherit eutils multilib

DESCRIPTION="Zope is a web application platform used for building high-performance, dynamic web sites."
HOMEPAGE="http://www.zope.org"
SRC_URI="http://www.zope.org/Products/Zope3/${PV}final/Zope-${PV}.tgz"

LICENSE="ZPL"
SLOT="${PV}"
IUSE=""

KEYWORDS="~x86"

RDEPEND="=dev-lang/python-2.4*"

DEPEND="${RDEPEND}
	>=app-shells/bash-2.0
	>=sys-apps/sed-4.0.5"

S="${WORKDIR}/Zope-${PV}"

ZUNAME=zope
ZGNAME=zope

ZS_DIR=${ROOT%/}/usr/$(get_libdir)
ZSERVDIR=${ZS_DIR}/${P}
ZSKELDIR=${ZSERVDIR}/zopeskel
ZINSTDIR=/var/lib/zope/${PN}

src_compile() {

	cd ${S}

	./configure --prefix=${D}${ZSERVDIR} --with-python=/usr/bin/python2.4 || die "Failed to configure."
	emake || die "Failed to compile."
}

src_install() {

	cd ${S}

	dodoc README.txt
	dodoc Zope/doc/*.txt
	for DIR in schema security skins style zcml zsync
	  do
	  docinto ${DIR}
	  dodoc Zope/doc/${DIR}/*
	done

	make install prefix=${D}${ZSERVDIR}

	dosym ../../share/doc/${PF} ${ZSERVDIR}/doc

	# copy the init script skeleton to zopeskel directory of our installation
	cp ${FILESDIR}/zope.initd ${D}${ZSKELDIR}/zope.initd
}

pkg_postinst() {
	# create the zope user and group for backward compatibility
	enewgroup ${ZGNAME} 261
	usermod -g ${ZGNAME} -c "Zope Admin User" -d /var/lib/zope -s /bin/bash ${ZUNAME} 2>&1 >/dev/null || \
	enewuser ${ZUNAME} 261 /bin/bash /var/lib/zope ${ZGNAME} -c "Zope Admin User"

	einfo "This release can create a default but *SIMPLIFIED** instance using the command: "
	einfo "    emerge --config =${PF}"
	einfo "Instance will be named zope, and will use /var/lib/zope/zope as its instance home."
	einfo
	ewarn "Current gentoo zope gotchas:"
	ewarn ".. Zope ${PV} is not yet fully supported by zope-config-0.*"
	ewarn ".. We use python2.4 to simplify packages managability"
}

pkg_prerm() {

	find ${ZSERVDIR}/lib/python -name \*.py[co] -exec rm -f {} \;
}

pkg_postrm() {

	rmdir /usr/$(get_libdir)/${ZSERVDIR} 2>/dev/null
}

pkg_config() {

	if [ -f /etc/init.d/${PN} -o -d ${ZINSTDIR} ]
	then
		ewarn "Default instance already exists, aborting.."
		ewarn "Please delete first /etc/init.d/${PN} and ${ZINSTDIR}"
		die "Failed to create default instance."
	fi

	mkdir -p ${ZINSTDIR}
	${ZSERVDIR}/bin/mkzopeinstance -d ${ZINSTDIR} -u admin:admin

	# remove unnecessary zope.initd
	rm -f ${ZINSTDIR}/zope.initd

	# log symlink
	rm -rf ${ZINSTDIR}/log
	mkdir -p /var/log/zope/${PN}
	ln -s /var/log/zope/${PN} ${ZINSTDIR}/log

	# permissions changes
	chmod go-rwx -R ${ZINSTDIR}
	chown ${ZUNAME}:${ZGNAME} -R ${ZINSTDIR} /var/log/zope/${PN}

	cp ${ZSKELDIR}/zope.initd /etc/init.d/${PN}
	chmod 755 /etc/init.d/${PN}
	sed -i -e "s|INSTANCE_HOME|${ZINSTDIR}|" /etc/init.d/${PN}
	sed -i -e "s|zopectl|zopectl -u ${ZUNAME}|" /etc/init.d/${PN}

	einfo "Default instance created at ${ZINSTDIR}"
	einfo "Created default zope user 'admin' with password 'admin'."
	einfo "Be warned that this instance is prepared to run as zope user only."
	einfo "To start instance (ports 8080,8021,) use: /etc/init.d/${PN} start"
}
