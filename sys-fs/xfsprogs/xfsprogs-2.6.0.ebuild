# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsprogs/xfsprogs-2.6.0.ebuild,v 1.2 2003/12/15 16:58:21 weeve Exp $

inherit flag-o-matic

SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
DESCRIPTION="xfs filesystem utilities"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~amd64 ~alpha ~mips ~hppa ~ia64 ~ppc ~sparc"

S=${WORKDIR}/${P}

DEPEND="sys-fs/e2fsprogs
	sys-devel/autoconf
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	cd ${S}
	chmod u+w include/builddefs.in
	sed -i -e "s:/usr/share/doc/${PN}:/usr/share/doc/${PF}:" \
	       -e 's:-O1::' -e '/-S $(PKG/d' \
	       -e 's:^PKG_\(.*\)_DIR[[:space:]]*= \(.*\)$:PKG_\1_DIR = $(DESTDIR)\2:' \
	       include/builddefs.in || die "sed failed"
}

src_compile() {
	replace-flags -O[2-9] -O1
	export OPTIMIZER="${CFLAGS}"
	export DEBUG=-DNDEBUG
	[ `use sparc` ] && unset PLATFORM

	autoconf || die

	./configure --prefix=/usr \
		    --bindir=/bin \
		    --sbindir=/sbin \
		    --libdir=/lib \
		    --libexecdir=/lib \
		    --mandir=/usr/share/man || die "config failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} DK_INC_DIR=${D}/usr/include/disk install install-dev || die "make install failed"

	cat ${S}/libhandle/.libs/libhandle.la | sed -e 's:installed=no:installed=yes:g' > ${D}/lib/libhandle.la

	dosym /lib/libhandle.so.1 /lib/libhandle.so
}
