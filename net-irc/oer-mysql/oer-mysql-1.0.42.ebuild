# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/oer-mysql/oer-mysql-1.0.42.ebuild,v 1.7 2004/11/24 21:54:47 swegener Exp $

inherit fixheadtails

MY_P="oer+MySQL"

DESCRIPTION="Free to use GPL'd IRC bot"
HOMEPAGE="http://oer.equnet.org/"
SRC_URI="http://oer.equnet.org/${MY_P}-1.0-42.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/libc
	 >=dev-db/mysql-3.23.52-r1
	 >=sys-apps/sed-3.02.80-r4"

S=${WORKDIR}/${MY_P}-dist

src_unpack() {
	unpack ${A}
	ht_fix_file ${S}/configure
}

src_compile() {

	CFLAGS=${CFLAGS} \
	./configure --host=${CHOST} \
		    --with-mysql=/usr || die "configure failed"

	cp Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" < Makefile.orig > Makefile

	emake mycrypt || die
	emake || die "make failed"

	# Make ebuild config work properly. 
	cp ${S}/pre_install.sh ${S}/pre_install.sh.orig
	sed -e "s:LOGTO=\"pre_install.log\":LOGTO=\"\/etc\/oer\/pre_install.log\":" \
	    -e "s:CRYPT=\`.\/mycrypt:CRYPT=\`\/usr\/share\/tools\/mycrypt:" \
	    -e "s:sample-configuration\/oer+MySQL.conf:\/etc\/oer\/oer+MySQL.conf:" \
		< ${S}/pre_install.sh.orig > ${S}/pre_install.sh

}

src_install() {

	dodir /usr/bin \
	      /etc/oer \
	      /usr/share/oer

	cp ${S}/oer+MySQL ${D}/usr/bin
	cp -r ${S}/tools ${S}/scripts ${D}/usr/share/oer
	cp ${S}/mycrypt ${S}/pre_install.sh ${D}/usr/share/oer/tools

}

pkg_postinst() {

	if ! groupmod oer
	then
		einfo "Creating oer group (gid=74)."
		groupadd oer -g 74 || die "failed to create oer group (gid=74)"
	fi
	if ! id oer
	then
		einfo "Creating oer user (uid=74)."
		useradd -d /usr/share/oer -g oer -s /bin/false -u 74 oer \
			|| die "failed to create oer user (uid=74)"
	fi

	chown -R oer:oer /etc/oer
	chmod 0700 /etc/oer
	chown oer:oer /usr/bin/oer+MySQL
	einfo "Setting /usr/bin/oer+MySQL suid oer."
	chmod 6755 /usr/bin/oer+MySQL

	echo

	einfo
	einfo "To create MySQL database and simple config for your bot execute:"
	einfo
	einfo "# ebuild /var/db/pkg/net-irc/${P}/${P}.ebuild config"
	einfo
	einfo "NOTICE: Your mysql server must be running when executing the command above."
	einfo
}

pkg_config() {

	cd /usr/share/oer
	tools/pre_install.sh /usr/bin
	chown oer:oer /etc/oer/oer+MySQL.conf
	chmod 0600 /etc/oer/oer+MySQL.conf /etc/oer/pre_install.log

	einfo
	einfo "If all went well, you can start you bot by typing:"
	einfo
	einfo "# oer+MySQL -f /etc/oer/oer+MySQL.conf"
	einfo

}
