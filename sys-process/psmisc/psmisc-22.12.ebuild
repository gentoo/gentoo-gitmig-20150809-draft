# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/psmisc/psmisc-22.12.ebuild,v 1.3 2010/08/05 17:54:39 ssuominen Exp $

EAPI=3
inherit autotools eutils

DESCRIPTION="A set of tools that use the proc filesystem"
HOMEPAGE="http://psmisc.sourceforge.net/"
SRC_URI="mirror://sourceforge/psmisc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="ipv6 nls selinux X"

RDEPEND=">=sys-libs/ncurses-5.2-r2
	selinux? ( sys-libs/libselinux )"
DEPEND="${RDEPEND}
	sys-devel/libtool
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-peekfd.patch
	use nls || epatch "${FILESDIR}"/${PN}-22.5-no-nls.patch
	eautoreconf
}

src_configure() {
	# the nls looks weird, but it's because we actually delete the nls stuff
	# above when USE=-nls.  this should get cleaned up so we dont have to patch
	# it out, but until then, let's not confuse users ... #220787
	econf \
		--disable-dependency-tracking \
		$(use_enable selinux) \
		$(use_enable ipv6) \
		$(use nls && use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
	use X || rm "${ED}"/usr/bin/pstree.x11
	# fuser is needed by init.d scripts
	dodir /bin
	mv "${ED}"/usr/bin/fuser "${ED}"/bin/ || die
	# easier to do this than forcing regen of autotools
	[[ -e ${ED}/usr/bin/peekfd ]] || rm -f "${ED}"/usr/share/man/man1/peekfd.1
}
