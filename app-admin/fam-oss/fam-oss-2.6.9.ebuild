# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/fam-oss/fam-oss-2.6.9.ebuild,v 1.15 2003/09/04 05:16:02 msterret Exp $

inherit libtool

MY_P="${P/-oss/}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="FAM, the File Alteration Monitor"
SRC_URI="ftp://oss.sgi.com/projects/fam/download/${MY_P}.tar.gz
	ftp://oss.sgi.com/projects/fam/download/contrib/dnotify.patch"
HOMEPAGE="http://oss.sgi.com/projects/fam/"

KEYWORDS="x86 ppc alpha sparc "
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"

DEPEND=">=dev-lang/perl-5.6.1"
RDEPEND=">=net-nds/portmap-5b-r6"

src_unpack() {
	unpack ${MY_P}.tar.gz

	cd ${S}
	patch -p1 < ${DISTDIR}/dnotify.patch || die
	patch -p1 < ${FILESDIR}/${PF}-gcc3.patch || die

	elibtoolize

	export WANT_AUTOCONF_2_5=1
	export WANT_AUTOMAKE_1_5=1
	automake --add-missing
	aclocal
	autoconf
	autoheader
}

src_install() {
	cp fam/fam.conf fam/fam.conf.old
	sed s:"local_only = false":"local_only = true":g fam/fam.conf.old >fam/fam.conf

	make DESTDIR=${D} install || die

	exeinto /etc/init.d
	doexe ${FILESDIR}/fam

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS TODO README*
}

