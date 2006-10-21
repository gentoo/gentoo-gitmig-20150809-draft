# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope/zope-3.3.0.ebuild,v 1.1 2006/10/21 21:30:06 radek Exp $

inherit eutils multilib

DESCRIPTION="Zope is a web application platform used for building high-performance, dynamic web sites"
HOMEPAGE="http://www.zope.org"
SRC_URI="http://www.zope.org/Products/Zope3/${PV}/Zope-${PV}.tgz"

LICENSE="ZPL"
SLOT="${PV}"
KEYWORDS="~sparc ~x86"
IUSE=""

RDEPEND="=dev-lang/python-2.4*"
DEPEND="${RDEPEND}
	>=app-shells/bash-2.0
	>=sys-apps/sed-4.0.5"

S=${WORKDIR}/Zope-${PV}

ZUNAME=zope
ZGNAME=zope

ZS_DIR=${ROOT%/}/usr/$(get_libdir)
ZSERVDIR=${ZS_DIR}/${P}
ZSKELDIR=${ZSERVDIR}/zopeskel
ZINSTDIR=/var/lib/zope/${P}

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

	einfo "This release can create a default instance using the command: "
	einfo "    emerge --config =${PF}"
	einfo "Instance (${P}) will be created in ${ZINSTDIR} as its home."
	einfo "System uid/gid for instance will be: ${ZUNAME}:${ZGNAME}"
}

pkg_prerm() {

	find ${ZSERVDIR}/lib/python -name \*.py[co] -exec rm -f {} \;
}

pkg_postrm() {

	rmdir /usr/$(get_libdir)/${ZSERVDIR} 2>/dev/null
	ewarn "Instances created for this package are NOT automaticaly deleted!"
	ewarn "Inspect these locations and manually remove them (if needed):"
	ewarn "    /etc/init.d/${P}"
	ewarn "    ${ZINSTDIR}"
}

pkg_config() {

	if [ -f /etc/init.d/${P} -o -d ${ZINSTDIR} ]
	then
		ewarn "Default instance already exists, aborting.."
		ewarn "Please delete first /etc/init.d/${P} and ${ZINSTDIR}"
		die "Failed to create default instance."
	fi

	mkdir -p ${ZINSTDIR}
	einfo "Instance ${P} creation, calling mkzopeinstance.."
	${ZSERVDIR}/bin/mkzopeinstance --non-interactive -d ${ZINSTDIR} -u admin:admin

	# bug in zope
	einfo "Patching ${ZINSTDIR}/etc/zdaemon.conf"
	sed -i -e 's|daemon on|daemon on\n\n  # socket has to be defined inside of instance\n  socket-name $INSTANCE/var/zdsock|' ${ZINSTDIR}/etc/zdaemon.conf

	# remove unnecessary zope.initd
	rm -f ${ZINSTDIR}/zope.initd

	# log symlink
	rm -rf ${ZINSTDIR}/log
	mkdir -p /var/log/zope/${PN}
	ln -s /var/log/zope/${PN} ${ZINSTDIR}/log

	# permissions changes
	chmod go-rwx -R ${ZINSTDIR}
	chown ${ZUNAME}:${ZGNAME} -R ${ZINSTDIR} /var/log/zope/${PN}

	cp ${ZSKELDIR}/zope.initd /etc/init.d/${P}
	chmod 755 /etc/init.d/${P}
	sed -i -e "s|INSTANCE_HOME|${ZINSTDIR}|" /etc/init.d/${P}
	sed -i -e "s|zopectl|zopectl -u ${ZUNAME}|" /etc/init.d/${P}

	einfo "Default instance created at ${ZINSTDIR}"
	einfo "Created default zope user 'admin' with password 'admin'."
	einfo "System uid/gid for instance is: ${ZUNAME}:${ZGNAME}."
	einfo "To start instance (default ports 8080,8021) use: /etc/init.d/${P} start"
	einfo "To start instance on every restart use: rc-update -a ${P} default"
}
