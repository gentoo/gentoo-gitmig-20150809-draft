# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/findutils/findutils-4.1.20-r1.ebuild,v 1.7 2004/02/11 01:42:41 brad_mssw Exp $

IUSE="nls build afs selinux"

inherit eutils

DESCRIPTION="GNU utilities to find files"
HOMEPAGE="http://www.gnu.org/software/findutils/findutils.html"

# Note this doesn't point to gnu.org because alpha.gnu.org has quit
# supplying the development versions.  If it comes back in the future
# then we might want to redirect the link.  See bug 18729
SRC_URI="ftp://alpha.gnu.org/gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz"

KEYWORDS="x86 amd64 ppc sparc hppa ~arm ~alpha ~ia64 ppc64"
SLOT="0"
LICENSE="GPL-2"

SELINUX_PATCH="findutils-4.1.20-selinux.diff.bz2"

DEPEND="virtual/glibc
	>=sys-apps/sed-4
	nls? ( sys-devel/gettext )
	x86? ( afs? ( net-fs/openafs ) )
	selinux? ( sys-libs/libselinux )"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}

	[ "${ARCH}" = "ppc64" ] && libtoolize -c -f 

	# Don't build or install locate because it conflicts with slocate,
	# which is a secure version of locate.  See bug 18729
	sed -i '/^SUBDIRS/s/locate//' Makefile.in

	#get a bigger environment as ebuild.sh is growing large
	epatch ${FILESDIR}/findutils-env-size.patch

	use selinux && epatch ${FILESDIR}/${SELINUX_PATCH}
}

src_compile() {
	local myconf=

	use nls || myconf="${myconf} --disable-nls"

	if use afs; then
		export CPPFLAGS=-I/usr/afsws/include
		export LDFLAGS=-lpam
		export LIBS=/usr/afsws/lib/pam_afs.so.1
	fi

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		${myconf} || die

	emake libexecdir=/usr/lib/find || die
}

src_install() {
	einstall libexecdir=${D}/usr/lib/find || die

	prepallman

	rm -rf ${D}/usr/var
	if ! use build; then
		dodoc COPYING NEWS README TODO ChangeLog
	else
		rm -rf ${D}/usr/share
	fi
}

pkg_postinst() {
	ewarn "Please note that the locate and updatedb binaries"
	ewarn "are not longer provided by findutils."
	ewarn "Please emerge slocate"
}
