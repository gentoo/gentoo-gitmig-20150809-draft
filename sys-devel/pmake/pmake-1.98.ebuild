# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/pmake/pmake-1.98.ebuild,v 1.10 2006/08/17 20:01:12 corsair Exp $

inherit eutils toolchain-funcs

MY_P="${P/-/_}"
DEB_PL="3"
DESCRIPTION="BSD build tool to create programs in parallel. Debian's version of NetBSD's make"
HOMEPAGE="http://www.netbsd.org/"
SRC_URI="mirror://debian/pool/main/p/pmake/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/p/pmake/${MY_P}-${DEB_PL}.diff.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/make_HEAD"

src_unpack() {
	unpack ${A} && cd ${S} || die

	# debian patch (which includes the mk defs)
	epatch ${WORKDIR}/${MY_P}-${DEB_PL}.diff

	# pmake makes the assumption that . and .. are the first two
	# entries in a directory, which doesn't always appear to be the
	# case on ext3...  (05 Apr 2004 agriffis)
	epatch ${FILESDIR}/${P}-skipdots.patch

	# Clean up headers to reduce warnings
	sed -i -e 's|^#endif.*|#endif|' *.h */*.h
}

src_compile() {
	local a=$ARCH
	[[ $a = x86 ]] && a=i386

	# The following CFLAGS are almost directly from Red Hat 8.0 and
	# debian/rules, so assume it's okay to void out the __COPYRIGHT
	# and __RCSID.  I've checked the source and don't see the point,
	# but whatever...  (07 Feb 2004 agriffis)
	CFLAGS="${CFLAGS} -Wall -Wno-unused -D_GNU_SOURCE \
		-DHAVE_STRERROR -DHAVE_STRDUP -DHAVE_SETENV \
		-D__COPYRIGHT\(x\)= -D__RCSID\(x\)= -I. \
		-DMACHINE=\\\"gentoo\\\" -DMACHINE_ARCH=\\\"${a}\\\""
	make -f Makefile.boot \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		|| die "make failed"
}

src_install() {
	insinto /usr/share/mk
	doins mk/*

	newbin bmake pmake || die
	dobin mkdep || die
	mv make.1 pmake.1
	doman mkdep.1 pmake.1
	dodoc PSD.doc/tutorial.ms
}
