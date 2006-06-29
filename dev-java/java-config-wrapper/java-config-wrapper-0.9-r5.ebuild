# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config-wrapper/java-config-wrapper-0.9-r5.ebuild,v 1.1 2006/06/29 20:10:24 nichoj Exp $

inherit eutils
DESCRIPTION="Wrapper for java-config"
HOMEPAGE="http://www.gentoo.org/proj/en/java"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
DEPEND="!<dev-java/java-config-1.3"

IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-qfile.patch
	epatch ${FILESDIR}/${P}-ignore_nonexistant_envs.patch
	epatch ${FILESDIR}/${P}-check_env_files.patch
	epatch ${FILESDIR}/${P}-url.patch
	epatch ${FILESDIR}/${P}-keyword_warning.patch
}

src_install() {
	dobin src/shell/*
}
