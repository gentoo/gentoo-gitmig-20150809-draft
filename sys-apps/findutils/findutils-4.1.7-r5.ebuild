# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/findutils/findutils-4.1.7-r5.ebuild,v 1.11 2004/06/29 15:58:53 vapier Exp $

inherit eutils gnuconfig

DESCRIPTION="GNU utilities to find files"
HOMEPAGE="http://www.gnu.org/software/findutils/findutils.html"
# Note this doesn't point to gnu.org because alpha.gnu.org has quit
# supplying the development versions.  If it comes back in the future
# then we might want to redirect the link.  See bug 18729
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64 ia64"
IUSE="nls build afs"

DEPEND="virtual/libc
	>=sys-apps/sed-4
	nls? ( sys-devel/gettext )
	x86? ( afs? ( net-fs/openafs ) )"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Don't build or install locate because it conflicts with slocate,
	# which is a secure version of locate.  See bug 18729
	sed -i '/^SUBDIRS/s/locate//' Makefile.in

	#get a bigger environment as ebuild.sh is growing large
	epatch ${FILESDIR}/findutils-env-size.patch
}

src_compile() {
	local myconf

	# Detect new systems properly
	gnuconfig_update

	use nls || myconf="${myconf} --disable-nls"

	if use afs; then
		export CPPFLAGS=-I/usr/afsws/include
		export LDFLAGS=-lpam
		export LIBS="/usr/afsws/lib/pam_afs.so.1 -lpam"
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
