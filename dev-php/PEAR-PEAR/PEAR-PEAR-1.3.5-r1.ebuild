# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PEAR/PEAR-PEAR-1.3.5-r1.ebuild,v 1.6 2005/03/18 08:17:38 sebastian Exp $

ARCHIVE_TAR="1.2"
CONSOLE_GETOPT="1.2"
PEAR="1.3.5"
XML_RPC="1.2.0"

DESCRIPTION="PEAR Base System."
HOMEPAGE="http://pear.php.net/"
SRC_URI="http://pear.php.net/get/Archive_Tar-${ARCHIVE_TAR}.tgz
	http://pear.php.net/get/Console_Getopt-${CONSOLE_GETOPT}.tgz
	http://pear.php.net/get/XML_RPC-${XML_RPC}.tgz
	http://pear.php.net/get/PEAR-${PEAR}.tgz"

LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc64 ~ppc ~ia64 ~sparc ~alpha ~hppa"
IUSE=""
DEPEND="virtual/php dev-php/php"
PDEPEND=">=dev-php/PEAR-Archive_Tar-1.1
		>=dev-php/PEAR-Console_Getopt-1.2
		>=dev-php/PEAR-XML_RPC-1.0.4"

pkg_preinst() {
	if [[ -d "${ROOT}"/usr/lib/php ]] && [[ ! -e "${ROOT}"/usr/share/php ]] ; then
		for f in /usr/lib/php/*
		do
			if [ "$f" != "/usr/lib/php/build" ] &&
			   [ "$f" != "/usr/lib/php/extensions" ]
				then mv $f /usr/share/php;
			fi
		done

		sed -i 's:/usr/lib/php:/usr/share/php:g' ${ROOT}/usr/bin/pear || die
		rm ${ROOT}/etc/pear.conf
	fi
}

src_install() {
	if has_version "dev-php/PEAR-PEAR"; then
		install_pear_without_bootstrap
	else
		bootstrap_pear
		install_pear_after_bootstrap
	fi
}

pkg_postinst() {
	ewarn "The location of the local PEAR repository has been changed"
	ewarn "from /usr/lib/php to /usr/share/php."
	ewarn "If you had a standard setup previously installed PEAR packages"
	ewarn "have been moved to the new location."
}

bootstrap_pear() {
	mkdir -p ${WORKDIR}/PEAR/XML/RPC

	cp -r ${WORKDIR}/PEAR-${PEAR}/OS ${WORKDIR}/PEAR/
	cp -r ${WORKDIR}/PEAR-${PEAR}/PEAR ${WORKDIR}/PEAR/
	cp ${WORKDIR}/PEAR-${PEAR}/PEAR.php ${WORKDIR}/PEAR/PEAR.php
	cp ${WORKDIR}/PEAR-${PEAR}/System.php ${WORKDIR}/PEAR/System.php
	cp ${WORKDIR}/PEAR-${PEAR}/scripts/pearcmd.php ${WORKDIR}/PEAR/pearcmd.php
	cp ${WORKDIR}/PEAR-${PEAR}/scripts/pear.sh ${WORKDIR}/PEAR/pear
	sed -i 's:@php_bin@:/usr/bin/php:g' ${WORKDIR}/PEAR/pear || die
	sed -i 's:@php_dir@:/usr/share/php:g' ${WORKDIR}/PEAR/pear || die

	cp -r ${WORKDIR}/Archive_Tar-${ARCHIVE_TAR}/Archive ${WORKDIR}/PEAR/Archive

	cp -r ${WORKDIR}/Console_Getopt-${CONSOLE_GETOPT}/Console ${WORKDIR}/PEAR/

	cp ${WORKDIR}/XML_RPC-${XML_RPC}/RPC.php ${WORKDIR}/PEAR/XML/RPC.php
	cp ${WORKDIR}/XML_RPC-${XML_RPC}/Server.php ${WORKDIR}/PEAR/XML/RPC/Server.php

	cd ${WORKDIR}/PEAR
	insinto /usr/share/php
	doins -r Archive Console OS PEAR XML *.php
	dobin pear
}

install_pear_after_bootstrap() {
	/usr/bin/php -d include_path=".:${D}/usr/share/php"	${D}/usr/share/php/pearcmd.php config-set doc_dir /usr/share/php/doc || die
	/usr/bin/php -d include_path=".:${D}/usr/share/php"	${D}/usr/share/php/pearcmd.php config-set data_dir /usr/share/php/data || die
	/usr/bin/php -d include_path=".:${D}/usr/share/php"	${D}/usr/share/php/pearcmd.php config-set php_dir /usr/share/php || die
	/usr/bin/php -d include_path=".:${D}/usr/share/php"	${D}/usr/share/php/pearcmd.php config-set test_dir /usr/share/php/test || die

	mkdir ${D}/etc
	cp $HOME/.pearrc ${D}/etc/pear.conf

	prepare_pear_install
	/usr/bin/php -d include_path=".:${D}/usr/share/php" ${D}/usr/share/php/pearcmd.php install --nodeps -R ${D} package.xml || die
}

install_pear_without_bootstrap() {
	prepare_pear_install
	pear install --nodeps -R ${D} package.xml || die
}

prepare_pear_install() {
	cp ${WORKDIR}/package.xml ${WORKDIR}/PEAR-${PEAR}
	cd ${WORKDIR}/PEAR-${PEAR}
}
