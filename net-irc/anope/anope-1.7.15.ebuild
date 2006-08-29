# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/anope/anope-1.7.15.ebuild,v 1.1 2006/08/29 22:54:17 gurligebis Exp $

inherit eutils

DESCRIPTION="Anope IRC Services"
HOMEPAGE="http://www.anope.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql"

DEPEND="mysql? ( dev-db/mysql )"

INSTALL_DIR="/opt/anope"

pkg_setup() {
	enewgroup anope
	enewuser anope -1 -1 ${INSTALL_DIR} anope
}

src_compile() {
	local myconf
	if ! use mysql; then
		myconf="${myconf} --without-mysql"
	fi
	#Threads cant be disabled currently
	#if ! use threads; then
	#	myconf="${myconf} --without-threads"
	#fi

	epatch ${FILESDIR}/pid-patch.diff

	econf \
		${myconf} \
		--bindir ${INSTALL_DIR} \
		--with-bindir=${INSTALL_DIR} \
		--with-datadir=${INSTALL_DIR}/data \
		--with-modules=${INSTALL_DIR}/modules \
		--with-encryption \
		--with-rungroup=anope \
		--with-permissions=077 \
	|| die "Configuration failed."

	sed -i -e "/^build:/s:$: language:g" "${S}"/Makefile || die "sed failed"

	emake || die "Make failed."
}

src_install() {
	dodir ${INSTALL_DIR}
	dodir ${INSTALL_DIR}/data
	dodir ${INSTALL_DIR}/data/logs
	dodir ${INSTALL_DIR}/data/languages
	dodir ${INSTALL_DIR}/data/modules
	dodir ${INSTALL_DIR}/data/modules/runtime
	dodir ${INSTALL_DIR}/modules

	dodir /var/run/anope
	fowners anope:anope /var/run/anope
	keepdir /var/run/anope

	fowners anope:anope ${INSTALL_DIR}
	fowners anope:anope ${INSTALL_DIR}/data
	fowners anope:anope ${INSTALL_DIR}/data/logs
	fowners anope:anope ${INSTALL_DIR}/data/languages
	fowners anope:anope ${INSTALL_DIR}/data/modules
	fowners anope:anope ${INSTALL_DIR}/data/modules/runtime
	fowners anope:anope ${INSTALL_DIR}/modules

	exeinto ${INSTALL_DIR}
	doexe src/services
	insinto ${INSTALL_DIR}/data
	newins data/example.conf services.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/anope.initd anope
	insinto /etc/conf.d
	newins ${FILESDIR}/anope.confd anope

	insinto ${INSTALL_DIR}/modules
	doins src/modules/*.so

	keepdir ${INSTALL_DIR}/data/logs

	insinto ${INSTALL_DIR}/data/languages
	doins lang/cat
	doins lang/de
	doins lang/en_us
	doins lang/es
	doins lang/fr
	doins lang/gr
	doins lang/hun
	doins lang/it
	doins lang/nl
	doins lang/pl
	doins lang/pt
	doins lang/ru
	doins lang/tr

	keepdir ${INSTALL_DIR}/data/modules/runtime

	insinto ${INSTALL_DIR}/data/modules
	doins src/protocol/*.so
	doins src/core/*.so

	fowners anope:anope ${INSTALL_DIR}/services
	fowners anope:anope ${INSTALL_DIR}/data/services.conf
	fowners anope:anope ${INSTALL_DIR}/data/languages/cat
	fowners anope:anope ${INSTALL_DIR}/data/languages/de
	fowners anope:anope ${INSTALL_DIR}/data/languages/en_us
	fowners anope:anope ${INSTALL_DIR}/data/languages/fr
	fowners anope:anope ${INSTALL_DIR}/data/languages/gr
	fowners anope:anope ${INSTALL_DIR}/data/languages/hun
	fowners anope:anope ${INSTALL_DIR}/data/languages/it
	fowners anope:anope ${INSTALL_DIR}/data/languages/nl
	fowners anope:anope ${INSTALL_DIR}/data/languages/pl
	fowners anope:anope ${INSTALL_DIR}/data/languages/pt
	fowners anope:anope ${INSTALL_DIR}/data/languages/ru
	fowners anope:anope ${INSTALL_DIR}/data/languages/tr
}

pkg_postinst() {
	echo
	ewarn "Anope won't run out of the box, you still have to configure it to match your IRCDs configuration."
	ewarn "Edit ${INSTALL_DIR}/data/services.conf to configure Anope."
	echo
}
