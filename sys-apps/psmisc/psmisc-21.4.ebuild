# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/psmisc/psmisc-21.4.ebuild,v 1.16 2004/10/23 02:26:30 pebenito Exp $

inherit eutils gnuconfig

SELINUX_PATCH="${P}-selinux.diff.bz2"

DESCRIPTION="A set of tools that use the proc filesystem"
HOMEPAGE="http://psmisc.sourceforge.net/"
SRC_URI="mirror://sourceforge/psmisc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ~ppc64 s390"
IUSE="nls selinux"

DEPEND=">=sys-libs/ncurses-5.2-r2
	selinux? ( sys-libs/libselinux
		sys-devel/libtool
		)
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}

	if use selinux; then
		# Necessary selinux patch
		epatch ${FILESDIR}/${SELINUX_PATCH}
		use nls || epatch ${FILESDIR}/${P}-no-nls-selinux.patch
	else
		use nls || epatch ${FILESDIR}/${P}-no-nls.patch
	fi
}

src_compile() {
	# Detect mips systems properly
	gnuconfig_update

	local myconf=""
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

	dodoc AUTHORS ChangeLog NEWS README
}
