# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/diffutils/diffutils-2.8.4-r4.ebuild,v 1.10 2003/12/29 03:34:51 kumba Exp $

IUSE="nls build static"

inherit eutils
inherit flag-o-matic

# sdiff SIGSEGVs with this on gcc-3.2.1, so take it out
# this fixes bug #13502
filter-flags "-mpowerpc-gfxopt"

S=${WORKDIR}/${P}
DESCRIPTION="Tools to make diffs and compare files"
HOMEPAGE="http://www.gnu.org/software/diffutils/diffutils.html"
SRC_URI="ftp://alpha.gnu.org/gnu/diffutils/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc alpha hppa mips ~arm ~amd64 ia64 ppc64"

DEPEND="virtual/glibc
	>=sys-apps/portage-2.0.47-r10
	>=sys-apps/sed-4
	nls? ( sys-devel/gettext )
	!build? ( sys-apps/texinfo sys-apps/help2man )"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}
	if [ -n "`use build`" ] ; then
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
	econf --build=${CHOST} `use_enable nls` || die "econf"

	if [ "`use static`" ] ; then
		emake LDFLAGS=-static || die
	else
		emake || die
	fi
}

src_install() {
	einstall || die

	if [ -z "`use build`" ] ; then
		dodoc COPYING ChangeLog NEWS README
	else
		rm -rf ${D}/usr/share/info
	fi
}
