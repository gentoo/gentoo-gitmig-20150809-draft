# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/psmisc/psmisc-21.2-r4.ebuild,v 1.7 2004/02/03 01:58:40 pebenito Exp $

SELINUX_PATCH="psmisc-21.2-selinux.diff.bz2"

DESCRIPTION="A set of tools that use the proc filesystem"
HOMEPAGE="http://psmisc.sourceforge.net/"
SRC_URI="mirror://sourceforge/psmisc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc ~sparc ~alpha ~hppa ~arm ~mips ia64 ppc64"
IUSE="nls selinux"

DEPEND=">=sys-libs/ncurses-5.2-r2
	selinux? ( sys-libs/libselinux )"

src_unpack() {
	unpack ${A}
	cd ${S}

	if use selinux; then
		# Necessary selinux patch
		epatch ${FILESDIR}/${SELINUX_PATCH}
	else
		# Fix gcc-3.3 compile issues.
		# <azarah@gentoo.org> (18 May 2003)

		# the section that this patch fixes
		# is deleted by the above selinux patch
		# so should only needed for ! use selinux
		# <pebenito@gentoo.org> (09 Aug 2003)

		epatch ${FILESDIR}/${P}-gcc33.patch
	fi

	# Killall segfault if an command is longer than 128 bytes, as
	# the realloc call is not done in such an way to update the
	# pointer that is used, thanks to bug submitted (bug #28234) by
	# Grant McDorman <grant.mcdorman@sympatico.ca>.
	epatch ${FILESDIR}/${P}-fix-realloc.patch
}

src_compile() {
	local myconf="--with-gnu-ld"
	use nls || myconf="${myconf} --disable-nls"
	use selinux && myconf="${myconf} --enable-flask"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	dosym killall /usr/bin/pidof

	# Some packages expect these to use /usr, others to use /
	dodir /bin
	mv ${D}/usr/bin/* ${D}/bin/
	cd ${D}/bin
	for f in * ; do
		dosym /bin/${f} /usr/bin/${f}
	done

	# We use pidof from baselayout.
	rm -f ${D}/bin/pidof
	dosym ../sbin/pidof /bin/pidof

	dodoc ABOUT-NLS AUTHORS ChangeLog NEWS README
}
