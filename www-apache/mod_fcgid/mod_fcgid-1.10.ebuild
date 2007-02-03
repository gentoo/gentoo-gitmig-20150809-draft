# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_fcgid/mod_fcgid-1.10.ebuild,v 1.5 2007/02/03 23:35:58 beandog Exp $

inherit apache-module

KEYWORDS="amd64 ppc x86"

DESCRIPTION="mod_fcgid is a binary-compatible alternative to mod_fastcgi with better process management."
HOMEPAGE="http://fastcgi.coremail.cn/"
SRC_URI="http://fastcgi.coremail.cn/${PN}.${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

S="${WORKDIR}/${PN}.${PV}"

APACHE2_MOD_CONF="20_${PN}"
APACHE2_MOD_DEFINE="FCGID"

APXS2_ARGS="-I ${S} -c ${PN}.c fcgid_bridge.c \
			fcgid_conf.c fcgid_pm_main.c \
			fcgid_spawn_ctl.c mod_fcgid.rc fcgid_bucket.c \
			fcgid_filter.c fcgid_protocol.c \
			arch/unix/fcgid_pm_unix.c \
			arch/unix/fcgid_proctbl_unix.c \
			arch/unix/fcgid_proc_unix.c"

DOCFILES="AUTHOR ChangeLog INSTALL.txt"

need_apache2
