# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/findutils/findutils-4.1.20-r1.ebuild,v 1.13 2004/03/24 01:16:22 kumba Exp $

inherit eutils flag-o-matic gnuconfig

SELINUX_PATCH="findutils-4.1.20-selinux.diff.bz2"

DESCRIPTION="GNU utilities to find files"
HOMEPAGE="http://www.gnu.org/software/findutils/findutils.html"
# Note this doesn't point to gnu.org because alpha.gnu.org has quit
# supplying the development versions.  If it comes back in the future
# then we might want to redirect the link.  See bug 18729
SRC_URI="ftp://alpha.gnu.org/gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz"

KEYWORDS="x86 amd64 ppc sparc hppa alpha ia64 ppc64 ~mips"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls build afs selinux"

DEPEND="virtual/glibc
	>=sys-apps/sed-4
	nls? ( sys-devel/gettext )
	x86? ( afs? ( net-fs/openafs ) )
	selinux? ( sys-libs/libselinux )"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}

	if [ "${ARCH}" == "ppc64" ] || [ "${ARCH}" == "sh" ] ; then
		# need to make sure the autotool files are updated to support
		# these architectures
		libtoolize -c -f || die "libtool failed"
		aclocal || die "aclocal failed"
		automake -c -f -a || die "automake failed"
		autoconf || die "autoconf failed"
	fi

	# Don't build or install locate because it conflicts with slocate,
	# which is a secure version of locate.  See bug 18729
	sed -i '/^SUBDIRS/s/locate//' Makefile.in

	#get a bigger environment as ebuild.sh is growing large
	epatch ${FILESDIR}/findutils-env-size.patch

	use selinux && epatch ${FILESDIR}/${SELINUX_PATCH}
}

src_compile() {

	# Detect mips systems properly
	use mips && gnuconfig_update

	if use afs ; then
		append-flags -I/usr/afsws/include
		append-ldflags -lpam
		export LIBS=/usr/afsws/lib/pam_afs.so.1
	fi
	export CPPFLAGS="${CXXFLAGS}"

	econf `use_enable nls` || die
	emake libexecdir=/usr/lib/find || die
}

src_install() {
	einstall libexecdir=${D}/usr/lib/find || die
	prepallman

	rm -rf ${D}/usr/var
	use build \
		&& rm -rf ${D}/usr/share \
		|| dodoc NEWS README TODO ChangeLog
}

pkg_postinst() {
	ewarn "Please note that the locate and updatedb binaries"
	ewarn "are not longer provided by findutils."
	ewarn "Please emerge slocate"
}
