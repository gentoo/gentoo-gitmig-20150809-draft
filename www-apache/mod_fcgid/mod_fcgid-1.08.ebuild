# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_fcgid/mod_fcgid-1.08.ebuild,v 1.1 2006/04/09 22:23:54 ramereth Exp $

inherit apache-module

MY_P=${PN}.${PV}

DESCRIPTION="mod_fcgid is an binary-compatible alternative to mod_fastcgi with
better process management"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
HOMEPAGE="http://fastcgi.coremail.cn/"
SRC_URI="http://fastcgi.coremail.cn/${MY_P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"

APACHE2_MOD_DEFINE="FCGID"
APACHE2_MOD_CONF="20_${PN}"
APXS2_ARGS="-I ${S} -c ${PN}.c fcgid_bridge.c \
			fcgid_conf.c fcgid_pm_main.c \
			fcgid_spawn_ctl.c mod_fcgid.rc fcgid_bucket.c \
			fcgid_filter.c fcgid_protocol.c \
			arch/unix/fcgid_pm_unix.c \
			arch/unix/fcgid_proctbl_unix.c \
			arch/unix/fcgid_proc_unix.c"

DOCFILES="AUTHOR ChangeLog INSTALL.txt"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${WORKDIR}
	mv ${MY_P} ${P}
}

need_apache2
