# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/diffutils/diffutils-2.8.4-r4.ebuild,v 1.20 2004/12/08 01:07:51 vapier Exp $

inherit eutils flag-o-matic gnuconfig

DESCRIPTION="Tools to make diffs and compare files"
HOMEPAGE="http://www.gnu.org/software/diffutils/diffutils.html"
SRC_URI="ftp://alpha.gnu.org/gnu/diffutils/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="nls build static"

DEPEND="virtual/libc
	>=sys-apps/portage-2.0.47-r10
	>=sys-apps/sed-4
	nls? ( sys-devel/gettext )
	!build? ( sys-apps/texinfo sys-apps/help2man )"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	gnuconfig_update

	if use build ; then
		#disable texinfo building so we can remove the dep
		sed -i -e 's:SUBDIRS = doc:SUBDIRS =:' \
			Makefile.in || die "Makefile.in sed"
	fi

	# Build fails with make -j5 or greater on pentium4.  This is because
	# the jobs creating the opjects, which depend on paths.h is sheduled
	# at the same time paths.h is generated.  This patch just fix a small
	# typeo that caused this.  This closes bug #8934.
	# <azarah@gentoo.org> (14 Oct 2002)
	epatch ${FILESDIR}/${P}-Makefile-fix-typeo.patch

	# Removes waitpid() call after pclose() on piped diff stream, closing
	# bug #11728, thanks to D Wollmann <converter@dalnet-perl.org>
	epatch ${FILESDIR}/${P}-sdiff-no-waitpid.patch

	# --tabsize option, undocumented in diff but used in sdiff, makes
	# diff dump core, closing #24238.
	# <taviso@gentoo.org> (1 Aug 2003)
	epatch ${FILESDIR}/${P}-tabsize-dumps-core.diff

	# the manpage for diff is better provided by the man-pagees package, so
	# we disable it here
	epatch ${FILESDIR}/${P}-no-manpage.patch
}

src_compile() {
	econf $(use_enable nls) || die "econf"

	use static && append-ldflags -static
	emake LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	einstall || die

	if ! use build ; then
		dodoc ChangeLog NEWS README
	else
		rm -r ${D}/usr/share/info
	fi
}
