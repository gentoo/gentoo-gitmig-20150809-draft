# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/tdb/tdb-1.1.5-r1.ebuild,v 1.5 2009/11/30 16:00:23 armin76 Exp $

EAPI="2"

inherit confutils eutils autotools

DESCRIPTION="Samba tdb"
HOMEPAGE="http://tdb.samba.org/"
SRC_URI="http://samba.org/ftp/tdb/${P}.tar.gz"
LICENSE="GPL-3"
IUSE="python tools tdbtest"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"

DEPEND="
	!<net-fs/samba-libs-3.4
	"
RDEPEND="${DEPEND}"

BINPROGS="bin/tdbdump bin/tdbtool bin/tdbbackup"

src_prepare() {
	eautoconf -Ilibreplace
	sed -e 's:$(SHLD_FLAGS) :$(SHLD_FLAGS) $(LDFLAGS) :' -i Makefile.in || die "sed failed"
}

src_configure() {

	econf \
		--sysconfdir=/etc/samba \
		--localstatedir=/var \
		$(use_enable python) \
	|| die "econf failed"

}

src_compile() {

	emake dirs || die "emake dirs failed"
	emake showflags || die "emake showflags failed"
	emake shared-build || die "emake shared-build failed"
	if use tools ; then emake ${BINPROGS} || die "emake binaries failed"; fi
	if use python ; then emake build-python || die "emake build-python failed"; fi
	if use tdbtest ; then make bin/tdbtest || die "emake tdbtest failed"; fi

}

src_install() {

	dolib.a sharedbuild/lib/libtdb.a
	dolib.so sharedbuild/lib/libtdb.so

	if use python || use tools ; then
		emake install DESTDIR="${D}" || die "emake install failed"
	fi

	if ! use tools ; then
		for prog in ${BINPROGS} ; do
			rm -f "${D}/usr/${prog}"
		done
	fi

	if use tdbtest ; then
		dobin bin/tdbtest
	fi

}
