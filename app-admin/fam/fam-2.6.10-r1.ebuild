# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/fam/fam-2.6.10-r1.ebuild,v 1.2 2004/01/25 23:34:57 vapier Exp $

IUSE=""

inherit libtool eutils

MY_P="${P/-oss/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="FAM, the File Alteration Monitor"
SRC_URI="ftp://oss.sgi.com/projects/fam/download/${MY_P}.tar.gz"
HOMEPAGE="http://oss.sgi.com/projects/fam/"

KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"

DEPEND=">=dev-lang/perl-5.6.1"
RDEPEND=">=net-nds/portmap-5b-r6"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}

	epatch ${FILESDIR}/dnotify.patch.new
	epatch ${FILESDIR}/fam-2.6.7-cleanup.patch
	epatch ${FILESDIR}/${P}-largefile.patch

	# The original code says that statvfs isn't supported
	# on linux, YET it enables it.  See:
	# http://bugs.gentoo.org/show_bug.cgi?id=24280
	epatch ${FILESDIR}/${P}-nostatvfs.patch

	elibtoolize

	# This one is old, and automake will install new one
	rm -rf ${S}/missing

	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.5
	aclocal
	autoconf
	automake --add-missing
}

src_install() {
	sed -i -e s:"local_only = false":"local_only = true":g fam/fam.conf

	make DESTDIR=${D} install || die

	exeinto /etc/init.d
	doexe ${FILESDIR}/fam

	dodoc AUTHORS ChangeLog INSTALL NEWS TODO README*
}
